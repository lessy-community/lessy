class Project < ApplicationRecord
  include ProjectLifecycle

  belongs_to :user
  has_many :tasks, dependent: :nullify

  validates :user, :name, :slug, presence: true
  validates :slug, uniqueness: { scope: :user, message: 'must be unique per user' },
                   format: { with: /\A[\w\-]{1,}\z/, message: 'must contain letters, numbers, underscores (_) and hiphens (-) only' }
  validates :name, length: { maximum: 100 }

  paginates_per 25

  before_validation do
    self.slug = self.name.parameterize
  end

  before_destroy :abandon_tasks, prepend: true

  private

  def abandon_tasks
    # rubocop:disable Rails/SkipsModelValidations
    tasks.update_all state: :abandoned, abandoned_at: Time.zone.now
    # rubocop:enable Rails/SkipsModelValidations
  end
end
