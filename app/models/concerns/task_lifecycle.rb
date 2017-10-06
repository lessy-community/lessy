module TaskLifecycle

  extend ActiveSupport::Concern

  included do
    class InvalidTransition < RuntimeError
      attr_reader :from, :to

      def initialize(state_from, state_to)
        @from = state_from
        @to = state_to
        super("Task cannot transition from '#{@from}' to '#{@to}'")
      end
    end

    class ForbiddenTransition < RuntimeError
      attr_reader :code, :from, :to

      def initialize(message, code, state_from, state_to)
        @code = code
        @from = state_from
        @to = state_to
        super(message)
      end
    end

    class InvalidState < RuntimeError
      def initialize(state = nil)
        if state.nil?
          super('State must be precised')
        else
          super("'#{state}' is not a valid state")
        end
      end
    end

    validate :newed_task_is_valid, if: :newed?
    validate :started_task_is_valid, if: :started?
    validate :planned_task_is_valid, if: :planned?
    validate :finished_task_is_valid, if: :finished?
    validate :abandoned_task_is_valid, if: :abandoned?

    scope :newed, -> { where(state: 'newed') }
    scope :started, -> { where(state: 'started') }
    scope :planned, -> { where(state: 'planned') }
    scope :finished, -> { where(state: 'finished') }
    scope :abandoned, -> { where(state: 'abandoned') }
    scope :not_abandoned, -> { where.not(state: 'abandoned') }

    def newed?
      self.state == 'newed'
    end

    def started?
      self.state == 'started'
    end

    def planned?
      self.state == 'planned'
    end

    def finished?
      self.state == 'finished'
    end

    def abandoned?
      self.state == 'abandoned'
    end

    def update_with_transition!(params)
      raise InvalidState.new unless params.key? :state
      raise InvalidState.new(params[:state]) unless %w(newed started planned finished abandoned).include? params[:state]

      if self.state == 'newed'
        raise InvalidTransition.new(self.state, params[:state]) unless %w(started abandoned).include? params[:state]
        params[:started_at] = DateTime.now if params[:state] == 'started'
        params[:abandoned_at] = DateTime.now if params[:state] == 'abandoned'
      end

      if self.state == 'started'
        raise InvalidTransition.new(self.state, params[:state]) unless %w(newed planned abandoned).include? params[:state]
        params[:started_at] = nil if params[:state] == 'newed'
        params[:planned_at] = DateTime.now if params[:state] == 'planned'
        params[:planned_count] = self.planned_count + 1 if params[:state] == 'planned'
        params[:abandoned_at] = DateTime.now if params[:state] == 'abandoned'
      end

      if self.state == 'planned'
        raise InvalidTransition.new(self.state, params[:state]) unless %w(newed planned finished abandoned).include? params[:state]
        params[:started_at] = nil if params[:state] == 'newed'
        params[:planned_at] = nil if params[:state] == 'newed'
        params[:planned_at] = DateTime.now if params[:state] == 'planned'
        params[:planned_count] = self.planned_count + 1 if params[:state] == 'planned'
        params[:finished_at] = DateTime.now if params[:state] == 'finished'
        params[:abandoned_at] = DateTime.now if params[:state] == 'abandoned'
      end

      if self.state == 'finished'
        raise InvalidTransition.new(self.state, params[:state]) unless %w(planned).include? params[:state]
        params[:finished_at] = nil
        params[:planned_at] = DateTime.now
        params[:planned_count] = self.planned_count + 1
      end

      if self.state == 'abandoned'
        raise InvalidTransition.new(self.state, params[:state])
      end

      self.update! params
      self
    end

  private

    def newed_task_is_valid
      errors.add :started_at, :cannot_be_set, message: 'cannot be set when task is newed' if started_at.present?
      errors.add :planned_at, :cannot_be_set, message: 'cannot be set when task is newed' if planned_at.present?
      errors.add :finished_at, :cannot_be_set, message: 'cannot be set when task is newed' if finished_at.present?
      errors.add :abandoned_at, :cannot_be_set, message: 'cannot be set when task is newed' if abandoned_at.present?
    end

    def started_task_is_valid
      errors.add :started_at, :must_be_set, message: 'must be set when task is started' if started_at.nil?
      errors.add :planned_at, :cannot_be_set, message: 'cannot be set when task is started' if planned_at.present?
      errors.add :finished_at, :cannot_be_set, message: 'cannot be set when task is started' if finished_at.present?
      errors.add :abandoned_at, :cannot_be_set, message: 'cannot be set when task is started' if abandoned_at.present?
    end

    def planned_task_is_valid
      errors.add :planned_at, :must_be_set, message: 'must be set when task is planned' if planned_at.nil?
      errors.add :finished_at, :cannot_be_set, message: 'cannot be set when task is planned' if finished_at.present?
      errors.add :abandoned_at, :cannot_be_set, message: 'cannot be set when task is planned' if abandoned_at.present?
    end

    def finished_task_is_valid
      errors.add :planned_at, :must_be_set, message: 'must be set when task is finished' if planned_at.nil?
      errors.add :finished_at, :must_be_set, message: 'must be set when task is finished' if finished_at.nil?
      errors.add :abandoned_at, :cannot_be_set, message: 'cannot be set when task is finished' if abandoned_at.present?
    end

    def abandoned_task_is_valid
      errors.add :finished_at, :cannot_be_set, message: 'cannot be set when task is abandoned' if finished_at.present?
      errors.add :abandoned_at, :must_be_set, message: 'must be set when task is abandoned' if abandoned_at.nil?
    end
  end

end
