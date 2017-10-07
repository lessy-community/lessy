class Api::WelcomeController < ApiController

  skip_before_action :require_login

  def not_found
    render_custom_error 'Endpoint does not exist', :missing_endpoint, ApiController, :not_found
  end

end
