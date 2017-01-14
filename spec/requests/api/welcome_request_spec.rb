require 'rails_helper'

RSpec.describe Api::WelcomeController, type: :request do

  describe '#not_found' do

    before do
      get '/api/endpoint_not_existing'
    end

    it 'fails' do
      expect(response).to have_http_status(:not_found)
    end

    it 'matches the error schema' do
      expect(response).to match_response_schema('error')
    end

    it 'returns an error message' do
      error = JSON.parse(response.body)
      expect(error['message']).to match(/Endpoint does not exist/)
    end

  end

end
