require 'rails_helper'
require 'shared_examples_for_failures'

RSpec.describe Api::Users::PasswordsController, type: :request do
  describe 'POST #create' do
    let(:user) { create :user, :activated, :password_reseted }
    let(:payload) { {
      user: {
        password: password,
      },
      token: token,
    } }

    subject { post api_users_passwords_path, params: payload,
                                             as: :json }

    context 'with valid attributes' do
      let(:password) { 'secret' }
      let(:token) { user.reset_password_token }

      before { subject }

      it 'succeeds' do
        expect(response).to have_http_status(:ok)
      end

      it 'matches the users/passwords/create schema' do
        expect(response).to match_response_schema('users/passwords/create')
      end

      it 'sets the reset token to nil' do
        expect(user.reload.reset_password_token).to be_nil
      end

      it 'returns the user' do
        json_user = JSON.parse(response.body)['data']
        expect(json_user['id']).to eq(user.id)
        expect(json_user['attributes']['username']).to eq(user.username)
        expect(json_user['attributes']['email']).to eq(user.email)
      end

      it 'returns a token valid for 1 month' do
        token = JSON.parse(response.body)['meta']['token']
        decoded_token = JsonWebToken.decode(token)
        expect(decoded_token[:exp]).to eq(1.month.from_now.to_i)
      end
    end

    context 'with missing attribute' do
      let(:password) { nil }
      let(:token) { user.reset_password_token }

      before { subject }

      it_behaves_like 'API errors', :unprocessable_entity, {
        errors: [{
          status: '422 Unprocessable Entity',
          code: 'parameter_missing',
          title: 'Parameter is missing',
          detail: 'A parameter is missing or empty but it is required.',
          source: { pointer: '/user/password' },
        }],
      }
    end

    context 'with invalid token' do
      let(:password) { 'secret' }
      let(:token) { 'not-the-token' }

      before { subject }

      it_behaves_like 'API errors', :not_found, {
        errors: [{
          status: '404 Not Found',
          code: 'record_not_found',
          title: 'Record not found',
          detail: 'Record cannot be found, it has been deleted or you may not have access to it.',
          source: { pointer: '/user' },
        }],
      }
    end
  end
end
