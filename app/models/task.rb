class Task < ApplicationRecord
  include TaskLifecycle

  belongs_to :user
  belongs_to :project

  validates :label, :user, :planned_count, presence: true
  validates :planned_count, numericality: { greater_than_or_equal_to: 0 }
  validates_uniqueness_of :order, scope: :user

  before_create :set_order_attribute
  before_create :set_planned_count_attribute

  delegate :name, to: :project, prefix: true, allow_nil: true

  scope :due_on_today, -> {
    today = DateTime.now
    where('? <= planned_at AND planned_at <= ?', today.beginning_of_day, today.end_of_day)
  }

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

private

  def set_order_attribute
    self.order = (user.tasks.maximum(:order) || 0) + 1 unless order.present?
  end

  def set_planned_count_attribute
    self.planned_count = 1 if planned_at.present? && planned_count == 0
  end

end
