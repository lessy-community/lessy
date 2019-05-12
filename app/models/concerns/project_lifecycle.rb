module ProjectLifecycle

  extend ActiveSupport::Concern
  include StateMachine

  included do
    validate :newed_project_is_valid, if: :newed?
    validate :started_project_is_valid, if: :started?
    validate :paused_project_is_valid, if: :paused?
    validate :finished_project_is_valid, if: :finished?

    init_state_machine do
      state :newed
      state :started
      state :paused
      state :finished

      transition :start, from: :newed, to: :started
      transition :pause, from: :started, to: :paused
      transition :restart, from: :paused, to: :started
      transition :finish, from: :started, to: :finished
    end

  protected

    def on_start(params)
      check_transition_no_limit_started_projects
      self.tasks.newed.update_all state: 'started', started_at: Time.current
      params[:started_at] = Time.current
      params
    end

    def on_pause(params)
      params[:paused_at] = Time.current
      self.tasks.started.update_all state: 'newed', started_at: nil
      params
    end

    def on_restart(params)
      check_transition_no_limit_started_projects
      self.tasks.newed.update_all state: 'started', started_at: Time.current
      params[:paused_at] = nil
      params
    end

  private

    def check_transition_no_limit_started_projects
      if user.projects.started.count >= 3
        raise StateMachine::ForbiddenTransition.new(self, :started, :reached_max_started, 'User cannot have more than 3 started projects')
      end
    end

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

      if finished_at.present? && Time.current < finished_at
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
