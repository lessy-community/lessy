require 'rails_helper'
require 'shared_examples_for_failures'

RSpec.describe Api::Users::AuthorizationsController, type: :request do

  describe 'POST #create' do
    context 'with valid username and password' do
      let(:payload) { { username: 'john', password: 'secret' } }

      before do
        Timecop.freeze Date.new(2017)
        create :user, :activated, username: 'john', password: 'secret'
        post '/api/users/authorizations', params: payload
      end

      after do
        Timecop.return
      end

      it 'succeeds' do
        expect(response).to have_http_status(:ok)
      end

      it 'matches the users/authorizations/create format' do
        expect(response).to match_response_schema('users/authorizations/create')
      end

      it 'returns a token valid for 1 month' do
        token = JSON.parse(response.body)['token']
        decoded_token = JsonWebToken.decode(token)
        expect(decoded_token[:exp]).to eq(1.month.from_now.to_i)
      end
    end

    context 'with inactive user' do
      let(:payload) { { username: 'john', password: 'secret' } }

      before do
        create :user, username: 'john', password: 'secret'
        post '/api/users/authorizations', params: payload
      end

      it_behaves_like 'API errors', :unauthorized, {
        errors: [{
          status: '401 Unauthorized',
          code: 'login_failed',
          title: 'Credentials are wrong',
          detail: 'You failed to authenticate yourself, credentials are probably wrong.',
        }],
      }
    end

    context 'with invalid password' do
      let(:payload) { { username: 'john', password: 'wrong secret' } }

      before do
        create :user, :activated, username: 'john', password: 'secret'
        post '/api/users/authorizations', params: payload
      end

      it_behaves_like 'API errors', :unauthorized, {
        errors: [{
          status: '401 Unauthorized',
          code: 'login_failed',
          title: 'Credentials are wrong',
          detail: 'You failed to authenticate yourself, credentials are probably wrong.',
        }],
      }
    end
  end

end
