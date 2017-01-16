class Project < ApplicationRecord

  belongs_to :user

  validates :user, :name, presence: true
  validates :started_at, presence: true, if: ->(project) { project.due_at? || project.finished_at? }
  validates :name, uniqueness: { scope: :user, message: 'should be unique per user' }
  validates :name, format: { with: /\A[a-z]{1}([a-z0-9_\-]{1,})*[a-z]{1}\z/, message: 'must begin and end by lowercase letters, contain only lowercase letters, numbers, underscore and hiphen, contain at least two characters' }
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
  alias_attribute :finished?, :finished_at?

  def in_progress?
    return false unless started?
    started_at <= DateTime.now && !finished?
  end

  def start_now!(due_at)
    if user.projects.in_progress.count >= 3
      errors.add :base, 'User cannot have more than 3 started projects'
      raise ActiveRecord::RecordInvalid.new(self)
    end
    update! started_at: DateTime.now, due_at: due_at
  end

  def finish_at!(date)
    update! finished_at: date
  end

private

  def due_at_not_before_started_at
    return false unless started?
    if due_at < started_at
      errors.add :due_at, 'cannot be set before started_at'
    end
  end

  def finished_at_between_started_at_and_today
    return false unless started?
    now = DateTime.now
    if started_at >= finished_at || finished_at > now
      errors.add :finished_at, 'must be between started_at and today'
    end
  end

end
