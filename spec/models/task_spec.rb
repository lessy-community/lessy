require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'validation' do
    it 'does not accept empty label' do
      task = build(:task, label: '')
      expect(task).to be_invalid
    end

    it 'requires a user' do
      task = build(:task, user: nil)
      expect(task).to be_invalid
    end
  end
end
