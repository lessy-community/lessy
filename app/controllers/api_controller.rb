class ApiController < ActionController::API
  before_action :require_login
  before_action :require_tos_accepted

  rescue_from ActiveRecord::RecordInvalid, with: -> (exception) do
    errors = ApiErrors::RecordInvalid.load(exception)
    render_errors errors, :unprocessable_entity
  end

  rescue_from ActiveRecord::RecordNotFound, with: -> (exception) do
    render_error ApiErrors::RecordNotFound.new(exception), :not_found
  end

  rescue_from ActionController::ParameterMissing, with: -> (exception) do
    render_error ApiErrors::ParameterMissing.new(exception), :unprocessable_entity
  end

  rescue_from StateMachine::InvalidTransition, with: -> (exception) do
    render_error ApiErrors::InvalidTransition.new(exception), :unprocessable_entity
  end

  rescue_from StateMachine::ForbiddenTransition, with: -> (exception) do
    render_error ApiErrors::ForbiddenTransition.new(exception), :unprocessable_entity
  end

protected

  def fetch_resource_params(resource, params_to_require, optional_params = [])
    resource_params = params.require(resource)
    begin
      parameters = resource_params.permit(*params_to_require).tap do |resource_params|
        resource_params.require(params_to_require)
      end
      parameters.merge(resource_params.permit(*optional_params))
    rescue ActionController::ParameterMissing => exception
      raise ActionController::ResourceParameterMissing.new resource, exception.param
    end
  end

  def require_login
    if current_user.nil?
      errors = [ApiErrors::AuthenticationRequired.new]
      render_errors errors, :unauthorized
    end
  end

  def require_tos_accepted
    return unless current_user && !current_user.accepted_tos?

    errors = [ApiErrors::TosNotAccepted.new]
    render_errors errors, :forbidden
  end

  def current_user
    @current_user ||= User.find_by_authorization_token(request.headers['Authorization'])
  end

  def render_errors(errors, http_status)
    @errors = errors
    render 'api/errors', status: http_status
  end

  def render_error(error, http_status)
    render_errors [error], http_status
  end
end
