class Api::WelcomeController < ApplicationController

  skip_before_action :require_login

  def not_found
    render_custom_error 'Endpoint does not exist', :missing_endpoint, ApplicationController, :not_found
  end

end
