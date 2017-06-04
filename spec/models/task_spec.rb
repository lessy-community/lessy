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

  describe '#order_after!' do
    let(:task) { create :task, order: 40, user: user }
    let!(:other_task) { create :task, order: 41, user: user }
    let!(:still_another_task) { create :task, order: 42, user: user }

    subject! { task.order_after! other_task }

    it 'sets order with other task order plus 1' do
      expect(task.reload.order).to eq(42)
    end

    it 'increments tasks strictly after the given one' do
      expect(other_task.reload.order).to eq(41)
      expect(still_another_task.reload.order).to eq(43)
    end

    it 'returns the list of impacted tasks' do
      expect(subject).to contain_exactly(task, still_another_task)
    end
  end

  describe '#order_first!' do
    let!(:other_task) { create :task, order: 41, user: user }
    let!(:still_another_task) { create :task, order: 42, user: user }
    let(:task) { create :task, order: 43, user: user }

    subject! { task.order_first! }

    it 'sets order to 1' do
      expect(task.reload.order).to eq(1)
    end

    it 'increments all the other tasks' do
      expect(other_task.reload.order).to eq(42)
      expect(still_another_task.reload.order).to eq(43)
    end

    it 'returns the list of impacted tasks' do
      expect(subject).to contain_exactly(task, other_task, still_another_task)
    end
  end
end
