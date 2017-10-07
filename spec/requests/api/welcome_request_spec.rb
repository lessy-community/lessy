require 'rails_helper'
require 'shared_examples_for_failures'

RSpec.describe Api::WelcomeController, type: :request do

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
