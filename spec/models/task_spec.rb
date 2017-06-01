require 'rails_helper'

RSpec.describe Task, type: :model do
  let(:user) { create :user }

  describe 'create!' do
    subject { Task.create! label: 'a task', user: user }

    it 'sets order to 1 by default' do
      Task.destroy_all
      expect(subject.order).to eq 1
    end

    it "sets order by incrementing maximum users' tasks order by 1" do
      create :task, order: 41, user: user
      expect(subject.order).to eq 42
    end
  end

  describe 'validation' do
    it 'does not accept empty label' do
      task = build(:task, label: '')
      expect(task).to be_invalid
    end

    it 'requires a user' do
      task = build(:task, user: nil)
      expect(task).to be_invalid
    end

    it 'requires order to be unique in user scope' do
      create :task, order: 42, user: user
      task = build(:task, order: 42, user: user)
      expect(task).to be_invalid
    end
  end
end
