require 'rails_helper'
require 'shared_examples_for_failures'

RSpec.describe Api::Users::ActivationsController, type: :request do

  describe 'POST #create' do
    let(:user) { create :user, email: 'john@doe.com' }

    context 'with valid attributes' do
      before do
        Timecop.freeze Date.new(2017)
        payload = {
          user: {
            username: 'john',
            password: 'secret',
          },
          token: user.activation_token,
        }
        post '/api/users/activations', params: payload
      end

      after do
        Timecop.return
      end

      it 'succeeds' do
        expect(response).to have_http_status(:ok)
      end

      it 'matches the users/activations/create schema' do
        expect(response).to match_response_schema('users/activations/create')
      end

      it 'activates the user' do
        expect(user.reload.activation_state).to eq('active')
      end

      it 'returns the new user' do
        contact = JSON.parse(response.body)['user']
        expect(contact['id']).not_to be_nil
        expect(contact['username']).to eq('john')
        expect(contact['email']).to eq('john@doe.com')
      end

      it 'returns a token valid for 1 month' do
        token = JSON.parse(response.body)['token']
        decoded_token = JsonWebToken.decode(token)
        expect(decoded_token[:exp]).to eq(1.month.from_now.to_i)
      end
    end

    context 'with missing attributes' do
      before do
        payload = {
          user: {
            password: 'secret',
          },
          token: user.activation_token,
        }
        post '/api/users/activations', params: payload
      end

      it_behaves_like 'missing param failures', 'User', 'username'
    end

    context 'with invalid username' do
      before do
        payload = {
          user: {
            username: 'John Doe',
            password: 'secret',
          },
          token: user.activation_token,
        }
        post '/api/users/activations', params: payload
      end

      it_behaves_like 'API errors', :unprocessable_entity, {
        errors: [{
          status: '422 Unprocessable Entity',
          code: 'invalid',
          title: 'Resource validation failed',
          detail: 'Resource cannot be saved because of validation constraints.',
          source: { pointer: '/user/username' },
        }],
      }
    end

    context 'with too long username' do
      before do
        payload = {
          user: {
            username: 'johnjohnjohnjohnjohnjohnjohn',
            password: 'secret',
          },
          token: user.activation_token,
        }
        post '/api/users/activations', params: payload
      end

      it_behaves_like 'API errors', :unprocessable_entity, {
        errors: [{
          status: '422 Unprocessable Entity',
          code: 'too_long',
          title: 'Resource validation failed',
          detail: 'Resource cannot be saved because of validation constraints.',
          source: { pointer: '/user/username' },
        }],
      }
    end

    context 'with existing username' do
      before do
        create :user, username: 'john'
        payload = {
          user: {
            username: 'john',
            password: 'secret',
          },
          token: user.activation_token,
        }
        post '/api/users/activations', params: payload
      end

      it_behaves_like 'API errors', :unprocessable_entity, {
        errors: [{
          status: '422 Unprocessable Entity',
          code: 'taken',
          title: 'Resource validation failed',
          detail: 'Resource cannot be saved because of validation constraints.',
          source: { pointer: '/user/username' },
        }],
      }
    end

    context 'with invalid token' do
      before do
        payload = {
          user: {
            username: 'john',
            password: 'secret',
          },
          token: 'not_the_token',
        }
        post '/api/users/activations', params: payload
      end

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
