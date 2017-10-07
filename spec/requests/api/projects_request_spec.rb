require 'rails_helper'
require 'shared_examples_for_failures'

RSpec.describe Api::ProjectsController, type: :request do

  let(:user) { create :user, :activated }

  describe 'PATCH #update' do
    let(:project) { create :project, :started, user: user,
                                               name: 'my-project',
                                               description: 'Old description' }
    let(:payload) { {
      name: 'new-name-for-a-project',
      description: 'New description',
      due_at: DateTime.new(2018, 1, 20).to_i,
    } }

    context 'with valid attributes' do
      before do
        patch "/api/projects/#{project.id}", params: { project: payload }, headers: { 'Authorization': user.token }, as: :json
      end

      it 'succeeds' do
        expect(response).to have_http_status(:ok)
      end

      it 'matches the projects/project schema' do
        expect(response).to match_response_schema('projects/project')
      end

      it 'saves the new project' do
        project.reload
        expect(project.name).to eq('new-name-for-a-project')
        expect(project.description).to eq('New description')
        expect(project.due_at).to eq(DateTime.new(2018, 1, 20))
      end

      it 'returns the new project' do
        api_project = JSON.parse(response.body)
        expect(api_project['id']).to eq(project.id)
        expect(api_project['name']).to eq('new-name-for-a-project')
        expect(api_project['description']).to eq('New description')
        expect(api_project['dueAt']).to eq(DateTime.new(2018, 1, 20).to_i)
      end
    end

    context 'with invalid name' do
      before do
        payload[:name] = 'an invalid name'
        patch "/api/projects/#{project.id}", params: { project: payload }, headers: { 'Authorization': user.token }, as: :json
      end

      it_behaves_like 'validation failed failures', 'Project', { name: ['invalid'] }
    end

    context 'with newed project' do
      let(:project) { create :project, :newed, user: user }

      before do
        patch "/api/projects/#{project.id}", params: { project: payload }, headers: { 'Authorization': user.token }, as: :json
      end

      it 'succeeds' do
        expect(response).to have_http_status(:ok)
      end

      it 'does not change due_at' do
        expect(project.reload.due_at).to be_nil
      end
    end

    context 'with missing attribute' do
      before do
        patch "/api/projects/#{project.id}", params: { }, headers: { 'Authorization': user.token }, as: :json
      end

      it_behaves_like 'missing param failures', 'Project', 'base'
    end

    context 'with unknown project' do
      before do
        Project.destroy_all
        patch '/api/projects/42', params: { project: payload }, headers: { 'Authorization': user.token }, as: :json
      end

      it_behaves_like 'not found failures', 'Project'
    end

    context 'when authenticated with another user' do
      let(:other_user) { create :user }

      before do
        patch "/api/projects/#{project.id}", params: { project: payload }, headers: { 'Authorization': other_user.token }, as: :json
      end

      it_behaves_like 'not found failures', 'Project'
    end

    context 'with invalid authentication' do
      before do
        patch "/api/projects/#{project.id}", params: { project: payload }, headers: { 'Authorization': 'not a token' }, as: :json
      end

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
    before do
      Timecop.freeze DateTime.new(2017, 1, 20)
    end

    after do
      Timecop.return
    end

    context 'when starting a project' do
      let(:project) { create :project, :newed, user: user }
      let(:payload) { {
        project: {
          state: 'started',
          due_at: DateTime.new(2017, 01, 27).to_i,
        },
      } }

      context 'with valid attributes' do
        before do
          put "/api/projects/#{ project.id }/state", params: payload, headers: { 'Authorization': user.token }, as: :json
        end

        it 'succeeds' do
          expect(response).to have_http_status(:ok)
        end

        it 'matches the projects/project schema' do
          expect(response).to match_response_schema('projects/project')
        end

        it 'saves due_at' do
          expect(project.reload.due_at).to eq(DateTime.new(2017, 1, 27))
        end

        it 'sets started_at to now' do
          expect(project.reload.started_at).to eq(DateTime.new(2017, 1, 20))
        end
      end

      context 'with a paused project' do
        let(:project) { create :project, :paused, user: user }

        before do
          put "/api/projects/#{ project.id }/state", params: payload, headers: { 'Authorization': user.token }, as: :json
        end

        it 'succeeds' do
          expect(response).to have_http_status(:ok)
        end

        it 'sets paused_at to nil' do
          expect(project.reload.paused_at).to be_nil
        end
      end

      context 'with already started project' do
        let(:project) { create :project, :started, user: user }

        before do
          put "/api/projects/#{ project.id }/state", params: payload, headers: { 'Authorization': user.token }, as: :json
        end

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
          put "/api/projects/#{ project.id }/state", params: payload, headers: { 'Authorization': user.token }, as: :json
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
          put "/api/projects/#{ project.id }/state", params: payload, headers: { 'Authorization': user.token }, as: :json
        end

        it_behaves_like 'validation failed failures', 'Project', { dueAt: ['cannot_be_before_started_at'] }
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
        before do
          put "/api/projects/#{ project.id }/state", params: payload, headers: { 'Authorization': user.token }, as: :json
        end

        it 'succeeds' do
          expect(response).to have_http_status(:ok)
        end

        it 'matches the projects/project schema' do
          expect(response).to match_response_schema('projects/project')
        end

        it 'saves finished_at' do
          expect(project.reload.finished_at).to eq(DateTime.new(2017, 1, 19))
        end
      end

      context 'with already finished project' do
        let(:project) { create :project, :finished, user: user }
        before do
          put "/api/projects/#{ project.id }/state", params: payload, headers: { 'Authorization': user.token }, as: :json
        end

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
          put "/api/projects/#{ project.id }/state", params: payload, headers: { 'Authorization': user.token }, as: :json
        end

        it_behaves_like 'validation failed failures', 'Project', { finishedAt: ['cannot_be_after_today'] }
      end

      context 'with a finish date before started_at' do
        before do
          payload[:project][:finished_at] = DateTime.new(2016, 12, 15).to_i
          put "/api/projects/#{ project.id }/state", params: payload, headers: { 'Authorization': user.token }, as: :json
        end

        it_behaves_like 'validation failed failures', 'Project', { finishedAt: ['cannot_be_before_started_at'] }
      end
    end

    context 'when stopping a project' do
      let(:project) { create :project, :started, user: user, started_at: DateTime.new(2017, 1, 1) }
      let(:payload) { {
        project: {
          state: 'paused',
        },
      } }

      context 'with valid project' do
        before do
          put "/api/projects/#{ project.id }/state", params: payload, headers: { 'Authorization': user.token }, as: :json
        end

        it 'succeeds' do
          expect(response).to have_http_status(:ok)
        end

        it 'matches the projects/project schema' do
          expect(response).to match_response_schema('projects/project')
        end

        it 'saves paused_at' do
          expect(project.reload.paused_at).to eq(DateTime.new(2017, 1, 20))
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
      let(:other_user) { create :user }

      before do
        put "/api/projects/#{ project.id }/state", params: payload, headers: { 'Authorization': other_user.token }, as: :json
      end

      it_behaves_like 'not found failures', 'Project'
    end
  end

end
