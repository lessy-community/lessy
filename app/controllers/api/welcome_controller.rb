class Api::WelcomeController < ApiController

  skip_before_action :require_login
  skip_before_action :require_tos_accepted

  def index
  end

  def not_found
    render_error ApiErrors::MissingEndpoint.new, :not_found
  end

end
