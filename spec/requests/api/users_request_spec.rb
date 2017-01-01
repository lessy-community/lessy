require 'rails_helper'

RSpec.describe Api::UsersController, type: :request do

  describe 'POST #create' do

    context 'with valid attributes' do
      before do
        payload = { email: 'john@doe.com' }
        post '/api/users', params: { user: payload }
      end

      it 'succeeds' do
        expect(response).to have_http_status(:created)
      end

      it 'matches the user schema' do
        expect(response).to match_response_schema('user')
      end

      it 'saves the new user' do
        expect(User.find_by(email: 'john@doe.com')).to be_present
      end

      it 'returns the new user' do
        contact = JSON.parse(response.body)
        expect(contact['id']).not_to be_nil
        expect(contact['email']).to eq('john@doe.com')
      end
    end

    context 'with invalid attributes' do
      before do
        post '/api/users', params: { }
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

    context 'with existing email' do
      let(:email) { 'john@doe.com' }

      before do
        create :user, email: email
        payload = { email: email }
        post '/api/users', params: { user: payload }
      end

      it 'fails' do
        expect(response).to have_http_status(:bad_request)
      end

      it 'matches the error schema' do
        expect(response).to match_response_schema('error')
      end

      it 'returns an error message' do
        error = JSON.parse(response.body)
        expect(error['message']).to match(/email is already taken/)
      end
    end

  end

  describe 'PATCH #activate' do
    let(:user) { create :user, email: 'john@doe.com' }

    context 'with valid attributes' do
      before do
        payload = {
          username: 'john',
          password: 'secret',
        }
        post "/api/users/#{ user.activation_token }/activate", params: { user: payload }
      end

      it 'succeeds' do
        expect(response).to have_http_status(:ok)
      end

      it 'matches the user schema' do
        expect(response).to match_response_schema('user')
      end

      it 'activates the user' do
        expect(user.reload.activation_state).to eq('active')
      end

      it 'returns the new user' do
        contact = JSON.parse(response.body)
        expect(contact['id']).not_to be_nil
        expect(contact['username']).to eq('john')
        expect(contact['email']).to eq('john@doe.com')
      end
    end

    context 'with missing attributes' do
      before do
        payload = {
          password: 'secret',
        }
        post "/api/users/#{ user.activation_token }/activate", params: { user: payload }
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

    context 'with invalid username' do
      before do
        payload = {
          username: 'John Doe',
          password: 'secret',
        }
        post "/api/users/#{ user.activation_token }/activate", params: { user: payload }
      end

      it 'fails' do
        expect(response).to have_http_status(:bad_request)
      end

      it 'matches the error schema' do
        expect(response).to match_response_schema('error')
      end

      it 'returns an error message' do
        error = JSON.parse(response.body)
        expect(error['message']).to match(/Username only allows/)
      end
    end

    context 'with existing username' do
      before do
        create :user, username: 'john'
        payload = {
          username: 'john',
          password: 'secret',
        }
        post "/api/users/#{ user.activation_token }/activate", params: { user: payload }
      end

      it 'fails' do
        expect(response).to have_http_status(:bad_request)
      end

      it 'matches the error schema' do
        expect(response).to match_response_schema('error')
      end

      it 'returns an error message' do
        error = JSON.parse(response.body)
        expect(error['message']).to match(/username is already taken/)
      end
    end

    context 'with invalid token' do
      before do
        payload = { password: 'secret' }
        post "/api/users/not_the_token/activate", params: { user: payload }
      end

      it 'fails' do
        expect(response).to have_http_status(:bad_request)
      end

      it 'matches the error schema' do
        expect(response).to match_response_schema('error')
      end

      it 'returns an error message' do
        error = JSON.parse(response.body)
        expect(error['message']).to match(/token matches no user/)
      end
    end

  end

end
