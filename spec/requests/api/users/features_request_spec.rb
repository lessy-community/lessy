# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_failures'

RSpec.describe Api::Users::FeaturesController, type: :request do
  let(:user) { create :user, :activated }
  let(:token) { user.token }

  describe 'GET #index' do
    subject { get me_features_api_users_path, headers: { 'Authorization': token } }

    context 'with a feature flag enabled' do
      before do
        Flipper.enable_actor :tmp_today, user
        subject
      end

      it 'succeeds' do
        expect(response).to have_http_status(:ok)
      end

      it 'matches the features/index schema' do
        expect(response).to match_response_schema('features/index')
      end

      it 'returns the flag' do
        data = JSON.parse(response.body)['data']
        expect(data.size).to be(1)
        expect(data[0]['id']).to eq('tmp_today')
      end
    end

    context 'with feature disabled' do
      before do
        Flipper.disable_actor :tmp_today, user
        subject
      end

      it 'succeeds' do
        expect(response).to have_http_status(:ok)
      end

      it 'matches the features/index schema' do
        expect(response).to match_response_schema('features/index')
      end

      it 'returns no flags' do
        data = JSON.parse(response.body)['data']
        expect(data).to be_empty
      end
    end

    context 'with ToS not accepted' do
      let!(:tos) { create :terms_of_service, :in_the_past }

      before { subject }

      it 'succeeds' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with invalid token' do
      let(:token) { 'not-a-token' }

      before { subject }

      it_behaves_like 'API errors', :unauthorized, errors: [{
        status: '401 Unauthorized',
        code: 'unauthorized',
        title: 'Authorization is required',
        detail: 'Resource you try to reach requires a valid Authorization token.',
      }]
    end
  end
end
