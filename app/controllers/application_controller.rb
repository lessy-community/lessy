class ApplicationController < ActionController::API

  before_action :require_login, except: [:client]

  def client
    render file: 'public/index.html'
  end

protected

  def require_login
    render_error 'Authentication is required', :unauthorized unless current_user
  end

  def current_user
    @current_user ||= User.find_by_authorization_token(request.headers['Authorization'])
  end

  def render_error(message, status = :bad_request)
    @message = message
    render 'api/errors/error', status: status
  end

end
