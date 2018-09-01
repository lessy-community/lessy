require 'rails_helper'
require 'shared_examples_for_failures'

RSpec.describe Api::Users::PasswordResetsController, type: :request do
  describe 'POST #create' do
    let!(:user) { create :user, user_trait, email: 'john@doe.com' }
    let(:user_trait) { :activated }
    let(:payload) { {
      user: {
        email: email,
      },
    } }

    subject { post api_users_password_resets_path, params: payload,
                                                   as: :json }

    context 'with an email corresponding to an existing user' do
      let(:email) { 'john@doe.com' }

      it 'succeeds with no content' do
        subject
        expect(response).to have_http_status(:no_content)
      end

      it 'sets a reset password token' do
        subject
        expect(user.reload.reset_password_token).not_to be_nil
      end

      it 'sends an email' do
        expect { subject }
          .to change { ActionMailer::Base.deliveries.count }.by(1)
      end
    end

    context 'with an email NOT corresponding to any user' do
      let(:email) { 'steve@doe.com' }

      before do
        User.where(email: email).destroy_all
        subject
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

    context 'with missing email attribute' do
      let(:email) { nil }

      before { subject }

      it_behaves_like 'API errors', :unprocessable_entity, {
        errors: [{
          status: '422 Unprocessable Entity',
          code: 'parameter_missing',
          title: 'Parameter is missing',
          detail: 'A parameter is missing or empty but it is required.',
          source: { pointer: '/user/email' },
        }],
      }
    end

    context 'with an inactive user' do
      let(:user_trait) { :inactive }
      let(:email) { 'john@doe.com' }

      before { subject }

      it_behaves_like 'API errors', :unprocessable_entity, {
        errors: [{
          status: '422 Unprocessable Entity',
          code: 'user_inactive',
          title: 'User is inactive',
          detail: 'The user did not activate its account.',
          source: { pointer: '/user' },
        }],
      }
    end
  end
end
