# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_failures'

RSpec.describe Api::Users::ActivationEmailsController, type: :request do
  describe 'POST #create' do
    let!(:user) { create :user, user_trait, email: 'john@doe.com' }
    let(:user_trait) { :inactive }
    let(:payload) do
      {
        user: {
          email: email,
        },
      }
    end

    subject { post api_users_activation_emails_path, params: payload, as: :json }

    context 'with valid attributes' do
      let(:email) { 'john@doe.com' }

      it 'succeeds with no content' do
        subject
        expect(response).to have_http_status(:no_content)
      end

      it 'sends an email' do
        expect { subject }
          .to change { ActionMailer::Base.deliveries.count }.by(1)
      end
    end

    context 'with missing attributes' do
      let(:email) { nil }

      before { subject }

      it_behaves_like 'API errors', :unprocessable_entity, errors: [{
        status: '422 Unprocessable Entity',
        code: 'parameter_missing',
        title: 'Parameter is missing',
        detail: 'A parameter is missing or empty but it is required.',
        source: { pointer: '/user/email' },
      }]
    end

    context 'with an invalid email' do
      let(:email) { 'steve@doe.com' }

      before do
        User.where(email: email).destroy_all
        subject
      end

      it_behaves_like 'API errors', :not_found, errors: [{
        status: '404 Not Found',
        code: 'record_not_found',
        title: 'Record not found',
        detail: 'Record cannot be found, it has been deleted or you may not have access to it.',
        source: { pointer: '/user' },
      }]
    end

    context 'with a already active user' do
      let(:user_trait) { :activated }
      let(:email) { 'john@doe.com' }

      it 'succeeds with no content' do
        subject
        expect(response).to have_http_status(:no_content)
      end

      it 'does not send an email' do
        expect { subject }
          .to change { ActionMailer::Base.deliveries.count }.by(0)
      end
    end
  end
end
