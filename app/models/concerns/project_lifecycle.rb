module ProjectLifecycle

  extend ActiveSupport::Concern

  included do
    class InvalidTransition < RuntimeError
      attr_reader :from, :to

      def initialize(state_from, state_to)
        @from = state_from
        @to = state_to
        super("Project cannot transition from '#{@from}' to '#{@to}'")
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

    validate :newed_project_is_valid, if: :newed?
    validate :started_project_is_valid, if: :started?
    validate :paused_project_is_valid, if: :paused?
    validate :finished_project_is_valid, if: :finished?

    scope :newed, -> { where(state: 'newed') }
    scope :started, -> { where(state: 'started') }
    scope :paused, -> { where(state: 'paused') }
    scope :finished, -> { where(state: 'finished') }

    def newed?
      self.state == 'newed'
    end

    def started?
      self.state == 'started'
    end

    def paused?
      self.state == 'paused'
    end

    def finished?
      self.state == 'finished'
    end

    def update_with_transition!(params)
      raise InvalidState.new unless params.key? :state
      raise InvalidState.new(params[:state]) unless %w(newed started paused finished).include? params[:state]

      if self.state == 'newed'
        raise InvalidTransition.new(self.state, params[:state]) unless %w(started).include? params[:state]
        raise ForbiddenTransition.new('User cannot have more than 3 started projects', :reached_max_started, self.state, params[:state]) if user.projects.started.count >= 3
        params[:started_at] = DateTime.now
      end

      if self.state == 'started'
        raise InvalidTransition.new(self.state, params[:state]) unless %w(paused finished).include? params[:state]
        params[:paused_at] = DateTime.now if params[:state] == 'paused'
      end

      if self.state == 'paused'
        raise InvalidTransition.new(self.state, params[:state]) unless %w(started).include? params[:state]
        raise ForbiddenTransition.new('User cannot have more than 3 started projects', :reached_max_started, self.state, params[:state]) if user.projects.started.count >= 3
        params[:paused_at] = nil
      end

      if self.state == 'finished'
        raise InvalidTransition.new(self.state, params[:state])
      end


      self.update! params
      self
    end

  private

    def newed_project_is_valid
      errors.add :started_at, :cannot_be_set, message: 'cannot be set when project is newed' if started_at.present?
      errors.add :due_at, :cannot_be_set, message: 'cannot be set when project is newed' if due_at.present?
      errors.add :paused_at, :cannot_be_set, message: 'cannot be set when project is newed' if paused_at.present?
      errors.add :finished_at, :cannot_be_set, message: 'cannot be set when project is newed' if finished_at.present?
    end

    def started_project_is_valid
      errors.add :started_at, :must_be_set, message: 'must be set when project is started' if started_at.nil?
      errors.add :due_at, :must_be_set, message: 'must be set when project is started' if due_at.nil?
      errors.add :paused_at, :cannot_be_set, message: 'cannot be set when project is started' if paused_at.present?
      errors.add :finished_at, :cannot_be_set, message: 'cannot be set when project is started' if finished_at.present?

      if started_at.present? && due_at.present? && due_at < started_at
        errors.add :due_at, :cannot_be_before_started_at, message: 'cannot be set before started_at'
      end
    end

    def paused_project_is_valid
      errors.add :started_at, :must_be_set, message: 'must be set when project is paused' if started_at.nil?
      errors.add :paused_at, :must_be_set, message: 'must be set when project is paused' if paused_at.nil?
      errors.add :finished_at, :cannot_be_set, message: 'cannot be set when project is paused' if finished_at.present?

      if started_at.present? && paused_at.present? && paused_at < started_at
        errors.add :paused_at, :cannot_be_before_started_at, message: 'cannot be set before started_at'
      end

      if started_at.present? && due_at.present? && due_at < started_at
        errors.add :due_at, :cannot_be_before_started_at, message: 'cannot be set before started_at'
      end
    end

    def finished_project_is_valid
      errors.add :started_at, :must_be_set, message: 'must be set when project is finished' if started_at.nil?
      errors.add :finished_at, :must_be_set, message: 'must be set when project is finished' if finished_at.nil?
      errors.add :paused_at, :cannot_be_set, message: 'cannot be set when project is finished' if paused_at.present?

      if finished_at.present? && DateTime.now < finished_at
        errors.add :finished_at, :cannot_be_after_today, message: 'cannot be set after today'
      end

      if started_at.present? && finished_at.present? && finished_at < started_at
        errors.add :finished_at, :cannot_be_before_started_at, message: 'cannot be set before started_at'
      end

      if started_at.present? && due_at.present? && due_at < started_at
        errors.add :due_at, :cannot_be_before_started_at, message: 'cannot be set before started_at'
      end
    end
  end

end
