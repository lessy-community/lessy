require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'validation' do
    it 'accepts multiple users with no username' do
      create :user, username: nil
      user = build :user, username: nil
      expect(user).to be_valid
    end
  end

end
