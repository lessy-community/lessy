require 'rails_helper'

describe UserMailer do
  describe 'activation_needed_email' do
    let(:user) { create :user }
    let(:mail) { described_class.activation_needed_email(user).deliver_now }

    it 'renders the subject' do
      expect(mail.subject).to eq('[Project Zero] Welcome on Project Zero!')
    end

    it 'renders the receiver email' do
      expect(mail.to).to eq([user.email])
    end

    it 'renders the sender email' do
      expect(mail.from).to eq(['noreply@projectzero.org'])
    end

    it 'renders the user activation link' do
      expect(mail.body.encoded).to match(user.activation_token)
    end
  end

  describe 'activation_success_email' do
    let(:user) { create :user, username: 'john' }
    let(:mail) { described_class.activation_success_email(user).deliver_now }

    it 'renders the subject' do
      expect(mail.subject).to eq('[Project Zero] Your account is now activated')
    end

    it 'renders the receiver email' do
      expect(mail.to).to eq([user.email])
    end

    it 'renders the sender email' do
      expect(mail.from).to eq(['noreply@projectzero.org'])
    end

    it 'renders the sender username' do
      expect(mail.body.encoded).to match(user.username)
    end
  end
end
