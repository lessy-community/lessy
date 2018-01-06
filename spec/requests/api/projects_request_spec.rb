require 'rails_helper'
require 'shared_examples_for_failures'

RSpec.describe Api::ProjectsController, type: :request do

  let(:user) { create :user, :activated }

  before do
    Timecop.freeze DateTime.new(2017, 1, 20)
  end

  after do
    Timecop.return
  end

  describe 'GET #show' do
    let(:token) { user.token }
    let(:project) { create :project, user: user }

    subject { get api_project_path(project.id), headers: { 'Authorization': token } }

    context 'with valid token' do
      before { subject }

      it 'succeeds' do
        expect(response).to have_http_status(:ok)
      end

      it 'matches the projects/show schema' do
        expect(response).to match_response_schema('projects/show')
      end

      it 'returns the corresponding project' do
        json_project = JSON.parse(response.body)['data']
        expect(json_project['id']).to eq(project.id)
      end
    end

    context 'with invalid authentication' do
      let(:token) { 'not a token' }

      before { subject }

      it_behaves_like 'API errors', :unauthorized, {
        errors: [{
          status: '401 Unauthorized',
          code: 'unauthorized',
          title: 'Authentication is required',
          detail: 'Resource you try to reach requires a valid Authentication token.',
        }],
      }
    end
  end

  describe 'PATCH #update' do
    let(:project) { create :project, :started, user: user,
                                               name: 'My project',
                                               description: 'Old description' }
    let(:payload) { {
      project: {
        name: 'New name for a project',
        description: 'New description',
        due_at: DateTime.new(2018, 1, 20).to_i,
      },
    } }
    let(:token) { user.token }

    subject { patch api_project_path(project.id), params: payload,
                                                  headers: { 'Authorization': token },
                                                  as: :json }

    context 'with valid attributes' do
      before { subject }

      it 'succeeds' do
        expect(response).to have_http_status(:ok)
      end

      it 'matches the projects/update schema' do
        expect(response).to match_response_schema('projects/update')
      end

      it 'saves the new project' do
        project.reload
        expect(project.name).to eq('New name for a project')
        expect(project.slug).to eq('new-name-for-a-project')
        expect(project.description).to eq('New description')
        expect(project.due_at).to eq(DateTime.new(2018, 1, 20))
      end

      it 'returns the new project' do
        api_project = JSON.parse(response.body)['data']
        expect(api_project['id']).to eq(project.id)
        expect(api_project['attributes']['name']).to eq('New name for a project')
        expect(api_project['attributes']['slug']).to eq('new-name-for-a-project')
        expect(api_project['attributes']['description']).to eq('New description')
        expect(api_project['attributes']['dueAt']).to eq(DateTime.new(2018, 1, 20).to_i)
      end
    end

    context 'with newed project' do
      let(:project) { create :project, :newed, user: user }

      before { subject }

      it 'succeeds' do
        expect(response).to have_http_status(:ok)
      end

      it 'does not change due_at' do
        expect(project.reload.due_at).to be_nil
      end
    end

    context 'with missing attribute' do
      let(:payload) { { } }

      before { subject }

      it_behaves_like 'API errors', :unprocessable_entity, {
        errors: [{
          status: '422 Unprocessable Entity',
          code: 'parameter_missing',
          title: 'Parameter is missing',
          detail: 'A parameter is missing or empty but it is required.',
          source: { pointer: '/project' },
        }],
      }
    end

    context 'with unknown project' do
      before do
        project.destroy!
        subject
      end

      it_behaves_like 'API errors', :not_found, {
        errors: [{
          status: '404 Not Found',
          code: 'record_not_found',
          title: 'Record not found',
          detail: 'Record cannot be found, it has been deleted or you may not have access to it.',
          source: { pointer: '/project' },
        }],
      }
    end

    context 'when authenticated with another user' do
      let(:token) { create(:user).token }

      before { subject }

      it_behaves_like 'API errors', :not_found, {
        errors: [{
          status: '404 Not Found',
          code: 'record_not_found',
          title: 'Record not found',
          detail: 'Record cannot be found, it has been deleted or you may not have access to it.',
          source: { pointer: '/project' },
        }],
      }
    end

    context 'with invalid authentication' do
      let(:token) { 'not a token' }

      before { subject }

      it_behaves_like 'API errors', :unauthorized, {
        errors: [{
          status: '401 Unauthorized',
          code: 'unauthorized',
          title: 'Authentication is required',
          detail: 'Resource you try to reach requires a valid Authentication token.',
        }],
      }
    end
  end

  describe 'PUT #update_state' do
    let(:token) { user.token }

    subject { put state_api_project_path(project.id), params: payload,
                                                      headers: { 'Authorization': token },
                                                      as: :json }

    context 'when starting a project' do
      let(:project) { create :project, :newed, user: user }
      let!(:task) { create :task, :newed, project: project }
      let(:payload) { {
        project: {
          state: 'started',
          due_at: DateTime.new(2017, 01, 27).to_i,
        },
      } }

      context 'with valid attributes' do
        before { subject }

        it 'succeeds' do
          expect(response).to have_http_status(:ok)
        end

        it 'matches the projects/update_state schema' do
          expect(response).to match_response_schema('projects/update_state')
        end

        it 'saves due_at' do
          expect(project.reload.due_at).to eq(DateTime.new(2017, 1, 27))
        end

        it 'sets started_at to now' do
          expect(project.reload.started_at).to eq(DateTime.new(2017, 1, 20))
        end

        it 'starts newed task' do
          expect(task.reload.state).to eq('started')
          expect(task.reload.started_at).to eq(DateTime.now)
        end
      end

      context 'with a paused project' do
        let(:project) { create :project, :paused, user: user }

        before { subject }

        it 'succeeds' do
          expect(response).to have_http_status(:ok)
        end

        it 'sets paused_at to nil' do
          expect(project.reload.paused_at).to be_nil
        end

        it 'starts newed task' do
          expect(task.reload.state).to eq('started')
          expect(task.reload.started_at).to eq(DateTime.now)
        end
      end

      context 'with already started project' do
        let(:project) { create :project, :started, user: user }

        before { subject }

        it_behaves_like 'API errors', :unprocessable_entity, {
          errors: [{
            status: '422 Unprocessable Entity',
            code: 'invalid_transition',
            title: 'Invalid transition',
            detail: "Project cannot transition from 'started' to 'started'",
            source: { pointer: '/project/state' }
          }]
        }
      end

      context 'with already 3 started projects' do
        before do
          create_list :project, 3, :started, user: user
          subject
        end

        it_behaves_like 'API errors', :unprocessable_entity, {
          errors: [{
            status: '422 Unprocessable Entity',
            code: 'reached_max_started',
            title: 'Forbidden transition',
            detail: 'User cannot have more than 3 started projects',
            source: { pointer: '/project/state' }
          }]
        }
      end

      context 'with invalid due_at' do
        before do
          payload[:project][:due_at] = DateTime.new(2016, 12, 31).to_i
          subject
        end

        it_behaves_like 'API errors', :unprocessable_entity, {
          errors: [{
            status: '422 Unprocessable Entity',
            code: 'cannot_be_before_started_at',
            title: 'Resource validation failed',
            detail: 'Resource cannot be saved because of validation constraints.',
            source: { pointer: '/project/due_at' },
          }],
        }
      end
    end

    context 'when finishing a project' do
      let(:project) { create :project, :started, user: user, started_at: DateTime.new(2017, 1, 1) }
      let(:payload) { {
        project: {
          state: 'finished',
          finished_at: DateTime.new(2017, 01, 19).to_i,
        },
      } }

      context 'with valid attributes' do
        before { subject }

        it 'succeeds' do
          expect(response).to have_http_status(:ok)
        end

        it 'matches the projects/update_state schema' do
          expect(response).to match_response_schema('projects/update_state')
        end

        it 'saves finished_at' do
          expect(project.reload.finished_at).to eq(DateTime.new(2017, 1, 19))
        end
      end

      context 'with already finished project' do
        let(:project) { create :project, :finished, user: user }

        before { subject }

        it_behaves_like 'API errors', :unprocessable_entity, {
          errors: [{
            status: '422 Unprocessable Entity',
            code: 'invalid_transition',
            title: 'Invalid transition',
            detail: "Project cannot transition from 'finished' to 'finished'",
            source: { pointer: '/project/state' }
          }]
        }
      end

      context 'with a finish date in the future' do
        before do
          payload[:project][:finished_at] = 15.days.from_now.to_i
          subject
        end

        it_behaves_like 'API errors', :unprocessable_entity, {
          errors: [{
            status: '422 Unprocessable Entity',
            code: 'cannot_be_after_today',
            title: 'Resource validation failed',
            detail: 'Resource cannot be saved because of validation constraints.',
            source: { pointer: '/project/finished_at' },
          }],
        }
      end

      context 'with a finish date before started_at' do
        before do
          payload[:project][:finished_at] = DateTime.new(2016, 12, 15).to_i
          subject
        end

        it_behaves_like 'API errors', :unprocessable_entity, {
          errors: [{
            status: '422 Unprocessable Entity',
            code: 'cannot_be_before_started_at',
            title: 'Resource validation failed',
            detail: 'Resource cannot be saved because of validation constraints.',
            source: { pointer: '/project/finished_at' },
          }],
        }
      end
    end

    context 'when pausing a project' do
      let(:project) { create :project, :started, user: user, started_at: DateTime.new(2017, 1, 1) }
      let!(:task) { create :task, :started, project: project }
      let(:payload) { {
        project: {
          state: 'paused',
        },
      } }

      context 'with valid project' do
        before { subject }

        it 'succeeds' do
          expect(response).to have_http_status(:ok)
        end

        it 'matches the projects/update_state schema' do
          expect(response).to match_response_schema('projects/update_state')
        end

        it 'saves paused_at' do
          expect(project.reload.paused_at).to eq(DateTime.new(2017, 1, 20))
        end

        it 'cancels started task' do
          expect(task.reload.state).to eq('newed')
          expect(task.reload.started_at).to be nil
        end
      end
    end

    context 'when authenticated with another user' do
      let(:project) { create :project, :newed, user: user }
      let(:payload) { {
        project: {
          state: 'started',
          finished_at: DateTime.new(2017, 01, 27).to_i,
        },
      } }
      let(:token) { create(:user).token }

      before { subject }

      it_behaves_like 'API errors', :not_found, {
        errors: [{
          status: '404 Not Found',
          code: 'record_not_found',
          title: 'Record not found',
          detail: 'Record cannot be found, it has been deleted or you may not have access to it.',
          source: { pointer: '/project' },
        }],
      }
    end
  end

end
