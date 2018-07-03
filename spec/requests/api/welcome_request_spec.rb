require 'rails_helper'
require 'shared_examples_for_failures'

RSpec.describe Api::WelcomeController, type: :request do

  describe 'GET #index' do
    let(:api) { JSON.parse(response.body) }

    subject { get api_path }

    it 'succeeds' do
      subject

      expect(response).to have_http_status(:ok)
    end

    it 'matches the welcome/index schema' do
      subject

      expect(response).to match_response_schema('welcome/index')
    end

    context 'when feature_registration flag is enabled' do
      before do
        Flipper.enable :feature_registration
      end

      it 'returns registrationDisabled at false' do
        subject

        expect(api['registrationDisabled']).to be false
      end
    end

    context 'when feature_registration flag is disabled' do
      before do
        Flipper.disable :feature_registration
      end

      it 'returns registrationDisabled at true' do
        subject

        expect(api['registrationDisabled']).to be true
      end
    end

    context 'when ToS are defined' do
      let!(:tos) { create :terms_of_service, :in_the_past }

      it 'returns current terms of service version' do
        subject

        expect(api['tosVersion']).to eq tos.version
      end
    end
  end

  describe '#not_found' do
    before do
      get '/api/endpoint_not_existing'
    end

    it_behaves_like 'API errors', :not_found, {
      errors: [{
        status: '404 Not Found',
        code: 'missing_endpoint',
        title: 'Missing endpoint',
        detail: 'Endpoint you try to reach does not exist, you might be using wrong HTTP verb.',
      }]
    }
  end

end
