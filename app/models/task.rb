class Task < ApplicationRecord

  belongs_to :user
  belongs_to :project

  validates :label, :user, :restarted_count, presence: true
  validates :restarted_count, numericality: { greater_than_or_equal_to: 0 }
  validates_uniqueness_of :order, scope: :user

  before_create :set_order_attribute

  scope :due_on_today, -> {
    today = DateTime.now
    where('? <= due_at AND due_at <= ?', today.beginning_of_day, today.end_of_day)
  }
  scope :pending, -> {
    today = DateTime.now
    where(finished_at: nil).where('due_at < ?', today.beginning_of_day)
  }
  scope :backlogged, -> {
    where(due_at: nil, finished_at: nil)
  }
  scope :not_abandoned, -> {
    where(abandoned_at: nil)
  }

  alias_attribute :finished?, :finished_at?
  alias_attribute :abandoned?, :abandoned_at?

  def finish_now!
    validates_not_finished
    validates_not_abandoned
    update! finished_at: DateTime.now
  end

  def start!
    validates_not_finished
    validates_not_abandoned
    update! due_at: DateTime.now
  end

  def restart!
    update! finished_at: nil,
            restarted_count: restarted_count + 1,
            due_at: DateTime.now
  end

  def abandon!
    validates_not_finished
    validates_not_abandoned
    update! abandoned_at: DateTime.now
  end

  def order_after!(after_task)
    impacted_tasks = user.tasks.where('"order" > ?', after_task.order)

    Task.transaction do
      impacted_tasks.update_all('"order" = "order" + 1')
      self.update! order: after_task.order + 1
    end

    [*impacted_tasks, self].uniq
  end

  def order_first!
    impacted_tasks = user.tasks

    Task.transaction do
      impacted_tasks.update_all('"order" = "order" + 1')
      self.update! order: 1
    end

    impacted_tasks
  end

private

  def validates_not_finished
    if finished?
      errors.add :base, :already_finished, message: 'Task is already finished'
      raise ActiveRecord::RecordInvalid.new(self)
    end
  end

  def validates_not_abandoned
    if abandoned?
      errors.add :base, :already_abandoned, message: 'Task is already abandoned'
      raise ActiveRecord::RecordInvalid.new(self)
    end
  end

  def set_order_attribute
    self.order = (user.tasks.maximum(:order) || 0) + 1 unless order.present?
  end

end
