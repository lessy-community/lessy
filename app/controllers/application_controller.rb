class ApplicationController < ActionController::API

  before_action :require_login, except: [:client]

  rescue_from ActiveRecord::RecordInvalid, with: :render_record_invalid

  def client
    render file: 'public/index.html'
  end

protected

  def require_login
    render_error 'Authentication is required', :unauthorized unless current_user
  end

  def current_user
    @current_user ||= User.find_by_authorization_token(request.headers['Authorization'])
  rescue ActiveRecord::RecordNotFound
    render_error 'User cannot be found', :not_found
  end

  def render_error(message, status = :bad_request)
    @message = message
    render 'api/errors/error', status: status
  end

  def render_record_invalid(exception)
    @resource = exception.record.model_name.name
    @errors = exception.record.errors.details.map do |field, errors|
      errors.map { |error| { field: field, code: error[:error] } }
    end.flatten
    render 'api/errors/record_invalid', status: :unprocessable_entity
  end

end
