class Task < ApplicationRecord
  include TaskLifecycle

  belongs_to :user
  belongs_to :project

  validates :label, :user, :planned_count, presence: true
  validates :planned_count, numericality: { greater_than_or_equal_to: 0 }
  validates_uniqueness_of :order, scope: :user

  before_create :set_planned_count_attribute

  delegate :name, to: :project, prefix: true, allow_nil: true

  scope :due_on_today, -> {
    today = Time.now
    where('? <= planned_at AND planned_at <= ?', today.beginning_of_day, today.end_of_day)
  }

  scope :not_finished_before, -> (date) {
    not_finished.or where.not('finished_at < ?', date.beginning_of_day)
  }

  paginates_per 50

  def order_incremental!(new_order)
    tasks_to_change = user.tasks.where('? <= "order" AND "order" < ?', new_order, self.order)
    impacted_tasks = tasks_to_change + [self]

    Task.transaction do
      tasks_to_change.update_all('"order" = "order" + 1')
      self.update! order: new_order
    end

    impacted_tasks
  end

  def order_decremental!(new_order)
    tasks_to_change = user.tasks.where('? < "order" AND "order" <= ?', self.order, new_order)
    impacted_tasks = tasks_to_change + [self]

    Task.transaction do
      tasks_to_change.update_all('"order" = "order" - 1')
      self.update! order: new_order
    end

    impacted_tasks
  end

  def sync_state_with_project
    if self.newed? && (self.project.nil? || self.project.started?)
      self.state = :started
      self.started_at = Time.now
    elsif self.started? && self.project.present? && !self.project.started?
      self.state = :newed
      self.started_at = nil
    end
  end

  def sync_order
    user_other_tasks = user.tasks.where.not(id: id)
    self.order = (user_other_tasks.maximum(:order) || 0) + 1
    self
  end

  private

  def set_planned_count_attribute
    self.planned_count = 1 if planned_at.present? && planned_count == 0
  end

end
