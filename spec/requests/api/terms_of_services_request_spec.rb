# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::TermsOfServicesController, type: :request do
  describe 'GET #current' do
    subject { get api_terms_of_services_current_path }

    context 'with no terms of service' do
      before do
        TermsOfService.destroy_all
        subject
      end

      it 'succeeds with no content' do
        expect(response).to have_http_status(:no_content)
      end
    end

    context 'with actual terms of service' do
      let!(:actual_tos) { create :terms_of_service, :in_the_past }
      let!(:next_tos) { create :terms_of_service, :in_the_future }

      before { subject }

      it 'succeeds' do
        expect(response).to have_http_status(:ok)
      end

      it 'matches the terms_of_services/current schema' do
        expect(response).to match_response_schema('terms_of_services/current')
      end

      it 'returns the actual terms of service' do
        tos_json = JSON.parse(response.body)['data']
        expect(tos_json['id']).to eq(actual_tos.id)
        expect(tos_json['attributes']['content']).to eq(actual_tos.content)
        expect(tos_json['attributes']['version']).to eq(actual_tos.version)
        expect(tos_json['attributes']['effectiveAt']).to eq(actual_tos.effective_at.to_i)
      end
    end
  end
end
