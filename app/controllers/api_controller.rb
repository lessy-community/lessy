class ApiController < ActionController::API

  before_action :require_login

  rescue_from ActiveRecord::RecordInvalid, with: -> (exception) do
    errors = ApiErrors::RecordInvalid.load(exception)
    render_errors errors, :unprocessable_entity
  end

  rescue_from ActiveRecord::RecordNotFound, with: -> (exception) do
    errors = [ApiErrors::RecordNotFound.new(exception)]
    render_errors errors, :not_found
  end

  rescue_from ActionController::ParameterMissing, with: -> (exception) do
    errors = [ApiErrors::ParameterMissing.new(exception)]
    render_errors errors, :unprocessable_entity
  end

  rescue_from StateMachine::InvalidTransition, with: -> (exception) do
    errors = [ApiErrors::InvalidTransition.new(exception)]
    render_errors errors, :unprocessable_entity
  end

  rescue_from StateMachine::ForbiddenTransition, with: -> (exception) do
    errors = [ApiErrors::ForbiddenTransition.new(exception)]
    render_errors errors, :unprocessable_entity
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

  def current_user
    @current_user ||= User.find_by_authorization_token(request.headers['Authorization'])
  end

  def render_errors(errors, http_status)
    @errors = errors
    render 'api/errors', status: http_status
  end

end
