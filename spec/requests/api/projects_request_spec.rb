require 'rails_helper'

RSpec.describe Api::ProjectsController, type: :request do

  let(:user) { create :user, :activated }

  describe 'POST #create' do

    context 'with valid attributes' do

      before do
        payload = { name: 'my-project' }
        post '/api/projects', params: { project: payload }, headers: { 'Authorization': user.token }
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
      end

    end

    context 'with missing attribute' do
      before do
        post '/api/projects', params: { project: {} }, headers: { 'Authorization': user.token }
      end

      it 'fails' do
        expect(response).to have_http_status(:bad_request)
      end

      it 'matches the error schema' do
        expect(response).to match_response_schema('error')
      end

      it 'returns an error message' do
        error = JSON.parse(response.body)
        expect(error['message']).to match(/param is missing or the value is empty/)
      end
    end

    context 'with invalid name' do
      before do
        payload = { name: 'An invalid name' }
        post '/api/projects', params: { project: payload }, headers: { 'Authorization': user.token }
      end

      it 'fails' do
        expect(response).to have_http_status(:bad_request)
      end

      it 'matches the error schema' do
        expect(response).to match_response_schema('error')
      end

      it 'returns an error message' do
        error = JSON.parse(response.body)
        expect(error['message']).to match(/Name must/)
      end
    end

    context 'with existing project' do
      before do
        create :project, user: user, name: 'my-project'
        payload = { name: 'my-project' }
        post '/api/projects', params: { project: payload }, headers: { 'Authorization': user.token }
      end

      it 'fails' do
        expect(response).to have_http_status(:bad_request)
      end

      it 'matches the error schema' do
        expect(response).to match_response_schema('error')
      end

      it 'returns an error message' do
        error = JSON.parse(response.body)
        expect(error['message']).to match(/Name should be unique per user/)
      end
    end

    context 'with invalid authentication' do
      before do
        payload = { name: 'my-project' }
        post '/api/projects', params: { project: payload }, headers: { 'Authorization': 'not a token' }
      end

      it 'fails' do
        expect(response).to have_http_status(:unauthorized)
      end

      it 'matches the error schema' do
        expect(response).to match_response_schema('error')
      end

      it 'returns an error message' do
        error = JSON.parse(response.body)
        expect(error['message']).to match(/Authentication is required/)
      end
    end
  end

  describe 'PATCH #update' do

    let(:project) { create :project, user: user, name: 'my-project', description: 'Old description' }
    let(:payload) { { name: 'new-name-for-a-project', description: 'New description' } }

    context 'with valid attributes' do

      before do
        patch "/api/projects/#{project.id}", params: { project: payload }, headers: { 'Authorization': user.token }
      end

      it 'succeeds' do
        expect(response).to have_http_status(:ok)
      end

      it 'matches the projects/project schema' do
        expect(response).to match_response_schema('projects/project')
      end

      it 'saves the new project' do
        expect(project.reload.description).to eq('New description')
      end

      it 'returns the new project' do
        api_project = JSON.parse(response.body)
        expect(api_project['id']).to eq(project.id)
        expect(api_project['name']).to eq('new-name-for-a-project')
        expect(api_project['description']).to eq('New description')
      end

    end

    context 'with invalid name' do

      before do
        payload[:name] = ''
        patch "/api/projects/#{project.id}", params: { project: payload }, headers: { 'Authorization': user.token }
      end

      it 'fails' do
        expect(response).to have_http_status(:bad_request)
      end

      it 'matches the error schema' do
        expect(response).to match_response_schema('error')
      end

      it 'returns an error message' do
        error = JSON.parse(response.body)
        expect(error['message']).to match(/Name must/)
      end
    end

    context 'with missing attribute' do
      before do
        patch "/api/projects/#{project.id}", params: { }, headers: { 'Authorization': user.token }
      end

      it 'fails' do
        expect(response).to have_http_status(:bad_request)
      end

      it 'matches the error schema' do
        expect(response).to match_response_schema('error')
      end

      it 'returns an error message' do
        error = JSON.parse(response.body)
        expect(error['message']).to match(/param is missing or the value is empty/)
      end
    end

    context 'with unknown project' do
      before do
        Project.destroy_all
        patch '/api/projects/42', params: { project: payload }, headers: { 'Authorization': user.token }
      end

      it 'fails' do
        expect(response).to have_http_status(:not_found)
      end

      it 'matches the error schema' do
        expect(response).to match_response_schema('error')
      end

      it 'returns an error message' do
        error = JSON.parse(response.body)
        expect(error['message']).to match(/Project cannot be found/)
      end
    end

    context 'when authenticated with another user' do
      let(:other_user) { create :user }

      before do
        patch "/api/projects/#{project.id}", params: { project: payload }, headers: { 'Authorization': other_user.token }
      end

      it 'fails' do
        expect(response).to have_http_status(:not_found)
      end

      it 'matches the error schema' do
        expect(response).to match_response_schema('error')
      end

      it 'returns an error message' do
        error = JSON.parse(response.body)
        expect(error['message']).to match(/Project cannot be found/)
      end
    end

    context 'with invalid authentication' do
      before do
        patch "/api/projects/#{project.id}", params: { project: payload }, headers: { 'Authorization': 'not a token' }
      end

      it 'fails' do
        expect(response).to have_http_status(:unauthorized)
      end

      it 'matches the error schema' do
        expect(response).to match_response_schema('error')
      end

      it 'returns an error message' do
        error = JSON.parse(response.body)
        expect(error['message']).to match(/Authentication is required/)
      end
    end
  end

  describe 'GET #find' do
    let(:user) { create :user, :activated, username: 'john' }

    before do
      @project = create(:project, user: user, name: 'my-project')
    end

    context 'when looking for own existing project' do
      before do
        get '/api/projects/john/my-project', headers: { 'Authorization': user.token }
      end

      it 'succeeds' do
        expect(response).to have_http_status(:ok)
      end

      it 'matches the projects/project schema' do
        expect(response).to match_response_schema('projects/project')
      end

      it 'returns the corresponding project' do
        json_project = JSON.parse(response.body)
        expect(json_project['id']).to eq(@project.id)
      end
    end

    context 'when looking for own existing project by user id' do
      before do
        get "/api/projects/#{ user.id }/my-project", headers: { 'Authorization': user.token }
      end

      it 'succeeds' do
        expect(response).to have_http_status(:ok)
      end

      it 'matches the projects/project schema' do
        expect(response).to match_response_schema('projects/project')
      end

      it 'returns the corresponding project' do
        json_project = JSON.parse(response.body)
        expect(json_project['id']).to eq(@project.id)
      end
    end

    context 'when authenticated with another user' do
      let(:other_user) { create :user }

      before do
        get '/api/projects/john/my-project', headers: { 'Authorization': other_user.token }
      end

      it 'fails' do
        expect(response).to have_http_status(:not_found)
      end

      it 'matches the error schema' do
        expect(response).to match_response_schema('error')
      end

      it 'returns an error message' do
        error = JSON.parse(response.body)
        expect(error['message']).to match(/Project cannot be found/)
      end
    end

    context 'when looking for a missing project' do
      before do
        @project.destroy
        get '/api/projects/john/my-project', headers: { 'Authorization': user.token }
      end

      it 'fails' do
        expect(response).to have_http_status(:not_found)
      end

      it 'matches the error schema' do
        expect(response).to match_response_schema('error')
      end

      it 'returns an error message' do
        error = JSON.parse(response.body)
        expect(error['message']).to match(/Project cannot be found/)
      end
    end

  end

end
