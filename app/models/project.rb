class Project < ApplicationRecord
  include ProjectLifecycle

  belongs_to :user
  has_many :tasks, dependent: :nullify

  validates :user, :name, :slug, presence: true
  validates :name, uniqueness: { scope: :user, message: 'must be unique per user' },
                   format: { with: /\A[\w\-]{1,}\z/, message: 'must contain letters, numbers, underscores (_) and hiphens (-) only' },
                   length: { maximum: 100 }

  paginates_per 25

end
