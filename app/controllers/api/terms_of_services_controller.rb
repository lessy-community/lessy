# frozen_string_literal: true

module Api
  class TermsOfServicesController < ApiController
    skip_before_action :require_login, only: [:current]

    def current
      @terms_of_service = TermsOfService.current
      head :no_content if @terms_of_service.nil?
    end
  end
end
