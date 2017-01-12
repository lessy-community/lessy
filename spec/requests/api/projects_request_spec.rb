require 'rails_helper'

RSpec.describe Api::ProjectsController, type: :request do

  describe 'POST #create' do

    let(:user) { create :user, :activated }

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

end
