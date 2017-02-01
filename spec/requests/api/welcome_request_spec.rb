require 'rails_helper'
require 'shared_examples_for_failures'

RSpec.describe Api::WelcomeController, type: :request do

  describe '#not_found' do
    before do
      get '/api/endpoint_not_existing'
    end

    it_behaves_like 'failures', :not_found, 'custom_error', {
      message: 'Endpoint does not exist',
      code: 'missing_endpoint',
      resource: 'ApplicationController',
    }
  end

end
