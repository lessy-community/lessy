class User < ApplicationRecord
  authenticates_with_sorcery!

  has_many :tasks, dependent: :destroy
  has_many :projects, dependent: :destroy
  belongs_to :terms_of_service

  before_create :setup_activation
  after_create :send_activation_needed_email!

  validates :email, uniqueness: { case_sensitive: false }
  validates :username, format: { with: /\A[a-z_\-]{1,}\z/, message: 'only allows lowercase letters, underscore and hiphen' },
                       length: { maximum: 25 },
                       exclusion: { in: %w(dashboard login register logout projects tasks users) },
                       uniqueness: { case_sensitive: false },
                       allow_nil: true

  def self.find_by_authorization_token(token)
    decoded_token = JsonWebToken.decode(token)
    return nil unless decoded_token
    User.find decoded_token[:user_id]
  end

  def self.find_by_identifier!(identifier)
    # identifier is either id or username
    User.where(username: identifier).or(User.where(id: identifier)).take!
  end

  def token(expiration = 1.day.from_now)
   JsonWebToken.encode({ user_id: self.id }, expiration)
  end

  def flipper_id
    "User##{id}"
  end

  def flipper_enabled?(flag)
    Flipper.enabled? flag, self
  end

  def inactive?
    activation_state == 'pending'
  end

  def accepted_tos?
    terms_of_service == TermsOfService.current
  end
end
