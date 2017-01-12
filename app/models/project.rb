class Project < ApplicationRecord
  belongs_to :user

  validates :user, :name, presence: true
  validates :name, uniqueness: { scope: :user, message: 'should be unique per user' }
  validates :name, format: { with: /\A[a-z]{1}([a-z0-9_\-]{1,})*[a-z]{1}\z/, message: 'must begin and end by lowercase letters, contain only lowercase letters, numbers, underscore and hiphen, contain at least two characters' }
end
