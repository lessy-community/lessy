class ApiController < ActionController::API

  before_action :require_login

  rescue_from ActiveRecord::RecordInvalid, with: :render_record_invalid
  rescue_from ActiveRecord::RecordNotFound, with: :render_record_not_found
  rescue_from ActionController::ParameterMissing, with: :render_parameter_missing
  rescue_from ActionController::ResourceParameterMissing, with: :render_parameter_missing
  rescue_from StateMachine::InvalidTransition, with: :render_invalid_transition
  rescue_from StateMachine::ForbiddenTransition, with: :render_forbidden_transition

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
    if exception.is_a? ActionController::ResourceParameterMissing
      @resource = exception.resource.to_s.camelize
      @field = exception.param
    else
      @resource = exception.param.to_s.camelize
      @field = 'base'
    end
    render 'api/errors/parameter_missing', status: :unprocessable_entity
  end

  def render_forbidden_transition(exception)
    @resource = exception.resource
    @code = exception.code
    @transition = {
      from: exception.from,
      to: exception.to,
    }
    render 'api/errors/forbidden_transition', status: :unprocessable_entity
  end

  def render_invalid_transition(exception)
    @resource = exception.resource
    @transition = {
      from: exception.from,
      to: exception.to,
    }
    render 'api/errors/invalid_transition', status: :unprocessable_entity
  end

end
