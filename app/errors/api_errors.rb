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

  class AuthenticationRequired < Base
    def initialize
      @status = '401 Unauthorized'
      @code = :unauthorized
      @title = 'Authentication is required'
      @detail = 'Resource you try to reach requires a valid Authentication token.'
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

end
