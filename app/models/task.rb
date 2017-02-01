class Task < ApplicationRecord

  belongs_to :user

  validates :label, :user, presence: true

end
