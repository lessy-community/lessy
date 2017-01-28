module ActionController
  class ResourceParameterMissing < ParameterMissing
    attr_reader :resource

    def initialize(resource, param)
      @resource = resource
      super(param)
    end
  end
end
