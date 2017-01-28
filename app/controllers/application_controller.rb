class ApplicationController < ActionController::API

  before_action :require_login, except: [:client]

  rescue_from ActiveRecord::RecordInvalid, with: :render_record_invalid
  rescue_from ActiveRecord::RecordNotFound, with: :render_record_not_found
  rescue_from ActionController::ParameterMissing, with: :render_parameter_missing

  def client
    render file: 'public/index.html'
  end

protected

  def require_resource_params(resource, params_to_require)
    resource_params = params.require(resource).permit(*params_to_require).tap do |resource_params|
      resource_params.require(params_to_require)
    end
  end

  def require_login
    render_custom_error 'Authentication is required', :authentication_required, User, :unauthorized unless current_user
  end

  def current_user
    @current_user ||= User.find_by_authorization_token(request.headers['Authorization'])
  end

  def render_custom_error(message, code, resource, status)
    @message = message
    @code = code
    @resource = resource.name
    render 'api/errors/custom_error', status: status
  end

  def render_record_invalid(exception)
    @resource = exception.record.model_name.name
    @errors = exception.record.errors.details.map do |field, errors|
      [
        field.to_s.camelize(:lower),
        errors.map { |error| error[:error] }
      ]
    end.to_h
    render 'api/errors/record_invalid', status: :unprocessable_entity
  end

  def render_record_not_found(exception)
    @resource = exception.model
    render 'api/errors/record_not_found', status: :not_found
  end

  def render_parameter_missing(exception)
    @resource = exception.param
    render 'api/errors/parameter_missing', status: :unprocessable_entity
  end

end
