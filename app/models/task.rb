class Task < ApplicationRecord

  belongs_to :user

  validates :label, :user, presence: true

  scope :due_on_today, -> {
    today = DateTime.now
    where('? <= due_at AND due_at <= ?', today.beginning_of_day, today.end_of_day)
  }

end
