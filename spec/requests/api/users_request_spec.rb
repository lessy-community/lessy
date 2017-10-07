require 'rails_helper'
require 'shared_examples_for_failures'

RSpec.describe Api::UsersController, type: :request do

  describe 'POST #create' do
    context 'with valid attributes' do
      before do
        Timecop.freeze Date.new(2017)
        payload = { email: 'john@doe.com' }
        post '/api/users', params: { user: payload }
      end

      after do
        Timecop.return
      end

      it 'succeeds' do
        expect(response).to have_http_status(:created)
      end

      it 'matches the users/create schema' do
        expect(response).to match_response_schema('users/create')
      end

      it 'saves the new user' do
        expect(User.find_by(email: 'john@doe.com')).to be_present
      end

      it 'returns the new user' do
        contact = JSON.parse(response.body)['user']
        expect(contact['id']).not_to be_nil
        expect(contact['email']).to eq('john@doe.com')
      end

      it 'returns a token valid for 1 day' do
        token = JSON.parse(response.body)['token']
        decoded_token = JsonWebToken.decode(token)
        expect(decoded_token[:exp]).to eq(1.day.from_now.to_i)
      end
    end

    context 'with missing paramenters' do
      before do
        post '/api/users', params: { }
      end

      it_behaves_like 'missing param failures', 'User', 'base'
    end

    context 'with existing email' do
      let(:email) { 'john@doe.com' }

      before do
        create :user, email: email
        payload = { email: email }
        post '/api/users', params: { user: payload }
      end

      it_behaves_like 'validation failed failures', 'User', { email: ['taken'] }
    end
  end

  describe 'GET #me' do
    let(:user) { create :user }
    let(:token) { user.token }

    subject! { get '/api/users/me', headers: { 'Authorization': token } }

    context 'with valid token' do
      it 'succeeds' do
        expect(response).to have_http_status(:ok)
      end

      it 'matches the users/user schema' do
        expect(response).to match_response_schema('users/me')
      end

      it 'returns the corresponding user' do
        json_user = JSON.parse(response.body)['user']
        expect(json_user['id']).to eq(user.id)
      end
    end

    context 'with token of a deleted user' do
      before do
        user.destroy
        get '/api/users/me', headers: { 'Authorization': token }
      end

      it_behaves_like 'not found failures', 'User'
    end

    context 'with expired token' do
      let(:token) { user.token(1.day.ago) }

      it_behaves_like 'API errors', :unauthorized, {
        errors: [{
          status: '401 Unauthorized',
          code: 'unauthorized',
          title: 'Authentication is required',
          detail: 'Resource you try to reach requires a valid Authentication token.',
        }],
      }
    end

    context 'with no Authorization header' do
      let(:token) { nil }

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
