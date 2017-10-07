module StateMachine

  extend ActiveSupport::Concern

  class InvalidTransition < RuntimeError
    attr_reader :resource, :from, :to

    def initialize(model, state_to)
      @resource = model.class.name
      @from = model.state
      @to = state_to
      super("#{@resource} cannot transition from '#{@from}' to '#{@to}'")
    end
  end

  class ForbiddenTransition < RuntimeError
    attr_reader :resource, :code, :from, :to

    def initialize(model, state_to, code, message)
      @resource = model.class.name
      @code = code
      @from = model.state
      @to = state_to
      super(message)
    end
  end

  class InvalidState < RuntimeError
    attr_reader :resource, :state

    def initialize(model, state = nil)
      @resource = model.class.name
      @state = state
      if @state.nil?
        super('State must be precised')
      else
        super("'#{@state}' is not a valid state")
      end
    end
  end

  included do
    def update_with_transition!(params)
      states = self.class.state_machine.states
      transitions = self.class.state_machine.transitions
      current_state = self.state.to_sym
      next_state = params[:state].to_sym if params.key? :state

      raise StateMachine::InvalidState.new(self) if next_state.nil?
      raise StateMachine::InvalidState.new(self, next_state) unless states.include? next_state

      if !transitions.key?(current_state) || \
          !transitions[current_state].key?(next_state)
        raise InvalidTransition.new(self, next_state)
      end

      name = transitions[current_state][next_state]
      handler = "on_#{name}".to_sym
      params = self.send(handler, params) if self.class.method_defined?(handler)

      self.update! params
      self
    end
  end

  module ClassMethods
    attr_reader :state_machine

    def init_state_machine(&block)
      @state_machine = StateMachine::Base.new(self)
      @state_machine.instance_eval &block
    end
  end

  class Base
    attr_reader :states
    attr_reader :transitions

    def initialize(klass)
      @states = []
      @transitions = {}
      @klass = klass
    end

    def state(name)
      @states << name

      is_state_method_name = "#{name}?".to_sym
      @klass.send :define_method, is_state_method_name, -> do
        self.state.to_sym == name
      end

      @klass.send :scope, name, -> { where(state: name) }
      @klass.send :scope, "not_#{name}", -> { where.not(state: name) }
    end

    def transition(name, from:, to:)
      from = [from] unless from.is_a? Array
      from.each do |from_elt|
        @transitions[from_elt] ||= {}
        @transitions[from_elt][to] = name
      end
    end
  end
end
