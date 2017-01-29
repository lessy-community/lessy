require 'rails_helper'

RSpec.describe User, type: :model do

  let(:user) { build :user }

  describe 'validation' do
    it 'accepts multiple users with no username' do
      create :user, username: nil
      user.username = nil
      expect(user).to be_valid
    end

    it 'does not accept reserved usernames' do
      reserved_usernames = ['dashboard', 'login', 'register', 'logout']
      reserved_usernames.each do |username|
        user.username = username
        expect(user).to be_invalid, "'#{ username }' username should be invalid"
      end
    end
  end

end
