module ApiErrors

  class Base
    attr_reader :status, :code, :title, :detail, :source_pointer
  end

  class MissingEndpoint < Base
    def initialize
      @status = '404 Not Found'
      @code = :missing_endpoint
      @title = 'Missing endpoint'
      @detail = 'Endpoint you try to reach does not exist, you might be using wrong HTTP verb.'
    end
  end

  class AuthorizationRequired < Base
    def initialize
      @status = '401 Unauthorized'
      @code = :unauthorized
      @title = 'Authorization is required'
      @detail = 'Resource you try to reach requires a valid Authorization token.'
    end
  end

  class SudoRequired < Base
    def initialize
      @status = '403 Forbidden'
      @code = :sudo_required
      @title = 'Sudo authorization token is required'
      @detail = 'Resource you try to reach requires higher permissions.'
    end
  end

  class TosNotAccepted < Base
    def initialize
      @status = '403 Forbidden'
      @code = :tos_not_accepted
      @title = 'Terms of service not accepted'
      @detail = 'Resource you try to reach requires that you accept the terms of service.'
    end
  end

  class LoginFailed < Base
    def initialize
      @status = '401 Unauthorized'
      @code = :login_failed
      @title = 'Credentials are wrong'
      @detail = 'You failed to authenticate yourself, credentials are probably wrong.'
    end
  end

  class UserInactive < Base
    def initialize
      @status = '422 Unprocessable Entity'
      @code = 'user_inactive'
      @title = 'User is inactive'
      @detail = 'The user did not activate its account.'
      @source_pointer = '/user'
    end
  end

  class ParameterMissing < Base
    def initialize(exception)
      if exception.is_a? ActionController::ResourceParameterMissing
        resource = exception.resource
        field = exception.param
      else
        resource = exception.param
      end
      @status = '422 Unprocessable Entity'
      @code = :parameter_missing
      @title = 'Parameter is missing'
      @detail = 'A parameter is missing or empty but it is required.'
      @source_pointer = "/#{resource.to_s.downcase}" + (field.present? ? "/#{field}" : '')
    end
  end

  class RecordNotFound < Base
    def initialize(exception)
      @status = '404 Not Found'
      @code = :record_not_found
      @title = 'Record not found'
      @detail = 'Record cannot be found, it has been deleted or you may not have access to it.'
      @source_pointer = "/#{exception.model.downcase}"
    end
  end

  class RecordInvalid < Base
    def self.load(exception)
      record = exception.record

      resource = record.model_name.name.downcase
      record.errors.details.map do |field, errors|
        errors.map do |error|
          RecordInvalid.new resource, field, error[:error]
        end
      end.flatten
    end

    def initialize(resource, field, error_code)
      @status = '422 Unprocessable Entity'
      @code = error_code
      @title = 'Resource validation failed'
      @detail = 'Resource cannot be saved because of validation constraints.'
      @source_pointer = "/#{resource}/#{field}"
    end
  end

  class InvalidTransition < Base
    def initialize(exception)
      @status = '422 Unprocessable Entity'
      @code = :invalid_transition
      @title = 'Invalid transition'
      @detail = exception.message
      @source_pointer = "/#{exception.resource.downcase}/state"
    end
  end

  class ForbiddenTransition < Base
    def initialize(exception)
      @status = '422 Unprocessable Entity'
      @code = exception.code
      @title = 'Forbidden transition'
      @detail = exception.message
      @source_pointer = "/#{exception.resource.downcase}/state"
    end
  end

  class RegistrationDisabled < Base
    def initialize
      @status = '403 Forbidden'
      @code = 'registration_disabled'
      @title = 'Registration disabled'
      @detail = 'Registration has been disabled by the administrator.'
    end
  end
end
