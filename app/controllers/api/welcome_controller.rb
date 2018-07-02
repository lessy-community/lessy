class Api::WelcomeController < ApiController

  skip_before_action :require_login
  skip_before_action :require_tos_accepted

  def index
  end

  def not_found
    errors = [ApiErrors::MissingEndpoint.new]
    render_errors errors, :not_found
  end

end
