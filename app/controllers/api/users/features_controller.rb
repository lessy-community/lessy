# frozen_string_literal: true

class Api::Users::FeaturesController < ApiController
  skip_before_action :require_tos_accepted, only: [:index]

  def index
    @features = current_user.features_enabled
  end
end
