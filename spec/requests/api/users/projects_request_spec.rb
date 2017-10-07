require 'rails_helper'
require 'shared_examples_for_failures'

RSpec.describe Api::Users::ProjectsController, type: :request do

  let(:user) { create :user, :activated }

  describe 'GET #index' do
    let(:json_response) { JSON.parse(response.body) }

    subject { get me_projects_api_users_path(user.id), headers: { 'Authorization': user.token } }

    context 'with no related task' do
      before do
        create_list :project, 3, user: user
        subject
      end

      it 'succeeds' do
        expect(response).to have_http_status(:ok)
      end

      it 'matches the projects/index schema' do
        expect(response).to match_response_schema('projects/index')
      end

      it 'returns the list of projects' do
        expect(json_response.length).to eq(3)
      end
    end

    context 'with related task' do
      let(:task) { create :task, user: user }

      before do
        create :project, user: user, tasks: [task]
        subject
      end

      it 'succeeds' do
        expect(response).to have_http_status(:ok)
      end

      it 'matches the projects/index schema' do
        expect(response).to match_response_schema('projects/index')
      end

      it 'returns id of related task' do
        json_project = json_response[0]
        expect(json_project['taskIds']).to contain_exactly(task.id)
      end
    end
  end

  describe 'POST #create' do
    let(:token) { user.token }
    let(:payload) { {
      project: {
        name: 'my-project',
      },
    } }

    subject { post me_projects_api_users_path, params: payload,
                                               headers: { 'Authorization': token },
                                               as: :json }

    context 'with valid attributes' do
      before { subject }

      it 'succeeds' do
        expect(response).to have_http_status(:created)
      end

      it 'matches the projects/project schema' do
        expect(response).to match_response_schema('projects/project')
      end

      it 'saves the new project' do
        expect(Project.find_by(name: 'my-project')).to be_present
      end

      it 'returns the new project' do
        project = JSON.parse(response.body)
        expect(project['id']).not_to be_nil
        expect(project['name']).to eq('my-project')
        expect(project['isInProgress']).to be false
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

    context 'with invalid name' do
      let(:payload) { {
        project: {
          name: 'An invalid name',
        },
      } }

      before { subject }

      it_behaves_like 'API errors', :unprocessable_entity, {
        errors: [{
          status: '422 Unprocessable Entity',
          code: 'invalid',
          title: 'Resource validation failed',
          detail: 'Resource cannot be saved because of validation constraints.',
          source: { pointer: '/project/name' },
        }],
      }
    end

    context 'with too long name' do
      let(:payload) { {
        project: {
          name: 'my-project-my-project-my-project-my-project-my-project-my-project-my-project-my-project-my-project-my-project',
        },
      } }

      before { subject }

      it_behaves_like 'API errors', :unprocessable_entity, {
        errors: [{
          status: '422 Unprocessable Entity',
          code: 'too_long',
          title: 'Resource validation failed',
          detail: 'Resource cannot be saved because of validation constraints.',
          source: { pointer: '/project/name' },
        }],
      }
    end

    context 'with existing project' do
      before do
        create :project, user: user, name: payload[:project][:name]
        subject
      end

      it_behaves_like 'API errors', :unprocessable_entity, {
        errors: [{
          status: '422 Unprocessable Entity',
          code: 'taken',
          title: 'Resource validation failed',
          detail: 'Resource cannot be saved because of validation constraints.',
          source: { pointer: '/project/name' },
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

end
