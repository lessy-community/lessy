class Project < ApplicationRecord

  belongs_to :user

  validates :user, :name, presence: true
  validates :name, uniqueness: { scope: :user, message: 'should be unique per user' }
  validates :name, format: { with: /\A[a-z]{1}([a-z0-9_\-]{1,})*[a-z]{1}\z/, message: 'must begin and end by lowercase letters, contain only lowercase letters, numbers, underscore and hiphen, contain at least two characters' }
  validate :due_at_not_before_started_at

  scope :in_progress, -> {
    today = DateTime.now
    where('started_at <= ? and ? <= due_at', today, today)
  }

  def started?
    started_at.present?
  end

  def in_progress?
    return false unless started?
    now = DateTime.now
    started_at <= now && now <= due_at
  end

  def start_now!(due_at)
    if user.projects.in_progress.count >= 3
      errors.add :base, 'User cannot have more than 3 started projects'
      raise ActiveRecord::RecordInvalid.new(self)
    end
    update! started_at: DateTime.now, due_at: due_at
  end

private

  def due_at_not_before_started_at
    return if due_at.nil? || started_at.nil?
    if due_at < started_at
      errors.add :due_at, 'cannot be set before started_at'
    end
  end

end
