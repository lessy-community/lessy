class Api::WelcomeController < ApiController

  skip_before_action :require_login

  def index
  end

  def not_found
    errors = [ApiErrors::MissingEndpoint.new]
    render_errors errors, :not_found
  end

end
