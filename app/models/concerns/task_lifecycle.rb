module TaskLifecycle

  extend ActiveSupport::Concern
  include StateMachine

  included do
    validate :newed_task_is_valid, if: :newed?
    validate :started_task_is_valid, if: :started?
    validate :planned_task_is_valid, if: :planned?
    validate :finished_task_is_valid, if: :finished?
    validate :abandoned_task_is_valid, if: :abandoned?

    init_state_machine do
      state :newed
      state :started
      state :planned
      state :finished
      state :abandoned

      # main workflow
      transition :start, from: :newed, to: :started
      transition :plan, from: [:newed, :started], to: :planned
      transition :replan, from: :planned, to: :planned
      transition :finish, from: :planned, to: :finished

      # canceled transitions
      transition :replan, from: :finished, to: :planned
      transition :unplan, from: :planned, to: :started
      transition :cancel, from: [:planned, :started], to: :newed

      # abandon
      transition :abandon, from: [:newed, :started, :planned], to: :abandoned
    end

  protected

    def on_start(params)
      params[:started_at] = Time.now
      params
    end

    def on_plan(params)
      params[:planned_at] = Time.now
      params[:started_at] = Time.now if self.started_at.nil?
      params[:planned_count] = self.planned_count + 1
      params
    end

    def on_replan(params)
      params[:finished_at] = nil
      params[:started_at] = Time.now if self.started_at.nil?
      params[:planned_at] = Time.now
      params[:planned_count] = self.planned_count + 1
      params
    end

    def on_unplan(params)
      params[:planned_at] = nil
      params
    end

    def on_finish(params)
      params[:finished_at] = Time.now
      params
    end

    def on_cancel(params)
      params[:started_at] = nil
      params[:planned_at] = nil
      params
    end

    def on_abandon(params)
      params[:abandoned_at] = Time.now
      params
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
      errors.add :started_at, :must_be_set, message: 'must be set when task is planned' if started_at.nil?
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
