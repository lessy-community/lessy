class Project < ApplicationRecord

  belongs_to :user

  validates :user, :name, presence: true
  validates :started_at, presence: true, if: :finished?
  validates :stopped_at, absence: true, if: :started?
  validates :name, uniqueness: { scope: :user, message: 'should be unique per user' }
  validates :name, format: { with: /\A[\w\-]{1,}\z/, message: 'must contain letters, numbers, underscores (_) and hiphens (-) only' }
  validate :due_at_not_before_started_at, if: :due_at?
  validate :finished_at_between_started_at_and_today, if: :finished?

  scope :in_progress, -> {
    where('started_at <= ?', DateTime.now).where(finished_at: nil)
  }
  scope :not_finished, -> {
    where(finished_at: nil)
  }
  scope :finished, -> {
    where.not(finished_at: nil)
  }

  alias_attribute :started?, :started_at?
  alias_attribute :stopped?, :stopped_at?
  alias_attribute :finished?, :finished_at?

  def in_progress?
    return false unless started?
    started_at <= DateTime.now && !finished?
  end

  def start_now!(due_at)
    if user.projects.in_progress.count >= 3
      errors.add :base, :reached_max_started, message: 'User cannot have more than 3 started projects'
      raise ActiveRecord::RecordInvalid.new(self)
    end
    update! started_at: DateTime.now, due_at: due_at, stopped_at: nil
  end

  def stop_now!
    update! started_at: nil, stopped_at: DateTime.now
  end

  def finish_at!(date)
    update! finished_at: date
  end

private

  def due_at_not_before_started_at
    return false unless started?
    if due_at < started_at
      errors.add :due_at, :before_started_at, message: 'cannot be set before started_at'
    end
  end

  def finished_at_between_started_at_and_today
    return false unless started?
    now = DateTime.now
    if started_at >= finished_at || finished_at > now
      errors.add :finished_at, :outside_started_at_and_today, message: 'must be between started_at and today'
    end
  end

end
