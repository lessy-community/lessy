class Task < ApplicationRecord

  belongs_to :user
  belongs_to :project

  validates :label, :user, :started_count, presence: true
  validates :started_count, numericality: { greater_than_or_equal_to: 0 }
  validates_uniqueness_of :order, scope: :user

  before_create :set_order_attribute
  before_create :set_started_count_attribute

  delegate :name, to: :project, prefix: true, allow_nil: true

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
    validates_not_abandoned
    update! finished_at: nil,
            due_at: DateTime.now,
            started_count: started_count + 1
  end

  def abandon!
    validates_not_finished
    validates_not_abandoned
    update! abandoned_at: DateTime.now
  end

  def order_incremental!(new_order)
    impacted_tasks = user.tasks.where('? <= "order" AND "order" < ?', new_order, self.order)

    Task.transaction do
      impacted_tasks.update_all('"order" = "order" + 1')
      self.update! order: new_order
    end

    impacted_tasks + [self]
  end

  def order_decremental!(new_order)
    impacted_tasks = user.tasks.where('? < "order" AND "order" <= ?', self.order, new_order)

    Task.transaction do
      impacted_tasks.update_all('"order" = "order" - 1')
      self.update! order: new_order
    end

    impacted_tasks + [self]
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

  def set_started_count_attribute
    self.started_count = 1 if due_at.present? && started_count == 0
  end

end
