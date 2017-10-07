require 'rails_helper'
require 'shared_examples_for_failures'

RSpec.describe Api::Users::ProjectsController, type: :request do

  let(:user) { create :user, :activated }

  describe 'GET #index' do
    let(:json_response) { JSON.parse(response.body) }

    context 'with no related task' do
      let!(:projects) { create_list :project, 3, user: user }

      subject! { get me_projects_api_users_path(user.id), headers: { 'Authorization': user.token } }

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
      let!(:project) { create :project, user: user }
      let!(:task) { create :task, project: project, user: user }

      subject! { get me_projects_api_users_path(user.id), headers: { 'Authorization': user.token } }

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
    context 'with valid attributes' do
      before do
        payload = { name: 'my-project' }
        post me_projects_api_users_path, params: { project: payload }, headers: { 'Authorization': user.token }, as: :json
      end

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
      before do
        post me_projects_api_users_path, params: { project: {} }, headers: { 'Authorization': user.token }, as: :json
      end

      it_behaves_like 'missing param failures', 'Project', 'base'
    end

    context 'with invalid name' do
      before do
        payload = { name: 'An invalid name' }
        post me_projects_api_users_path, params: { project: payload }, headers: { 'Authorization': user.token }, as: :json
      end

      it_behaves_like 'validation failed failures', 'Project', { name: ['invalid'] }
    end

    context 'with too long name' do
      before do
        payload = { name: 'my-project-my-project-my-project-my-project-my-project-my-project-my-project-my-project-my-project-my-project' }
        post me_projects_api_users_path, params: { project: payload }, headers: { 'Authorization': user.token }, as: :json
      end

      it_behaves_like 'validation failed failures', 'Project', { name: ['too_long'] }
    end

    context 'with existing project' do
      before do
        create :project, user: user, name: 'my-project'
        payload = { name: 'my-project' }
        post me_projects_api_users_path, params: { project: payload }, headers: { 'Authorization': user.token }, as: :json
      end

      it_behaves_like 'validation failed failures', 'Project', { name: ['taken'] }
    end

    context 'with invalid authentication' do
      before do
        payload = { name: 'my-project' }
        post me_projects_api_users_path, params: { project: payload }, headers: { 'Authorization': 'not a token' }, as: :json
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

end
