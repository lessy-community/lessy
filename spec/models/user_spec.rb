require 'rails_helper'

RSpec.describe User, type: :model do
  it { should belong_to(:terms_of_service) }

  let(:user) { build :user }

  describe 'validation' do
    it 'accepts multiple users with no username' do
      create :user, username: nil
      user.username = nil
      expect(user).to be_valid
    end

    it 'does not accept reserved usernames' do
      reserved_usernames = [
        'dashboard', 'login', 'register', 'logout',
        'projects', 'tasks', 'users',
      ]
      reserved_usernames.each do |username|
        user.username = username
        expect(user).to be_invalid, "'#{ username }' username should be invalid"
      end
    end
  end

  describe '.find_by_authorization_token' do
    let(:user) { create :user }

    subject { User.find_by_authorization_token(token) }

    context 'when token is valid' do
      let(:token) { user.token(expiration: 1.day.from_now) }

      it 'returns the user' do
        expect(subject).to eq(user)
      end
    end

    context 'when token is expired' do
      let(:token) { user.token(expiration: 1.day.ago) }

      it 'returns nil' do
        expect(subject).to be_nil
      end
    end

    context 'when token corresponds to a destroyed user' do
      let(:token) { user.token(expiration: 1.day.from_now) }

      before do
        user.destroy
      end

      it 'returns nil' do
        expect(subject).to be_nil
      end
    end

    context 'when token is malformed' do
      let(:token) do
        JWT.encode({}, Rails.application.secrets.secret_key_base, 'HS256')
      end

      it 'returns nil' do
        expect(subject).to be_nil
      end
    end
  end

  describe '#accepted_tos?' do
    subject { user.accepted_tos? }

    context 'when there is no ToS' do
      let(:user) { build :user, :not_accepted_tos }

      before do
        TermsOfService.destroy_all
      end

      it 'returns true' do
        expect(subject).to be true
      end
    end

    context 'when ToS are in the future and user did not accept them' do
      let!(:tos) { create :terms_of_service, :in_the_future }
      let(:user) { build :user, :not_accepted_tos }

      it 'returns true' do
        expect(subject).to be true
      end
    end

    context 'when user accepted the current ToS' do
      let!(:tos) { create :terms_of_service, :in_the_past }
      let(:user) { build :user, terms_of_service: tos }

      it 'returns true' do
        expect(subject).to be true
      end
    end

    context 'when user did not accept the current ToS' do
      let!(:tos_1) { create :terms_of_service, effective_at: 2.months.ago }
      let!(:tos_2) { create :terms_of_service, effective_at: 1.month.ago }
      let(:user) { build :user, terms_of_service: tos_1 }

      it 'returns false' do
        expect(subject).to be false
      end
    end
  end
end
