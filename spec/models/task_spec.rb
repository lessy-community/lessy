require 'rails_helper'

RSpec.describe Task, type: :model do
  let(:user) { create :user }

  before do
    Timecop.freeze DateTime.new(2017, 1, 20)
  end

  after do
    Timecop.return
  end

  describe 'create!' do
    subject { Task.create! label: 'a task', state: 'planned', planned_count: 0, planned_at: DateTime.new(2017), user: user }

    it 'sets order to 1 by default' do
      Task.destroy_all
      expect(subject.order).to eq 1
    end

    it "sets order by incrementing maximum users' tasks order by 1" do
      create :task, order: 41, user: user
      expect(subject.order).to eq 42
    end

    it 'sets planned_count to 1 if planned_at is set' do
      expect(subject.planned_count).to eq 1
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

  describe '#state' do
    context 'when it is newed' do
      let(:task) { build :task, :newed }

      it 'does not accept started_at' do
        task.started_at = DateTime.new(2017, 1, 1)
        expect(task).to be_invalid
      end

      it 'does not accept planned_at' do
        task.planned_at = DateTime.new(2017, 1, 30)
        expect(task).to be_invalid
      end

      it 'does not accept finished_at' do
        task.finished_at = DateTime.new(2017, 1, 15)
        expect(task).to be_invalid
      end

      it 'does not accept abandoned_at' do
        task.abandoned_at = DateTime.new(2017, 1, 15)
        expect(task).to be_invalid
      end
    end

    context 'when it is started' do
      let(:task) { build :task, :started }

      it 'requires started_at' do
        task.started_at = nil
        expect(task).to be_invalid
      end

      it 'does not accept planned_at' do
        task.planned_at = DateTime.new(2017, 1, 30)
        expect(task).to be_invalid
      end

      it 'does not accept finished_at' do
        task.finished_at = DateTime.new(2017, 1, 15)
        expect(task).to be_invalid
      end

      it 'does not accept abandoned_at' do
        task.abandoned_at = DateTime.new(2017, 1, 15)
        expect(task).to be_invalid
      end
    end

    context 'when it is planned' do
      let(:task) { build :task, :planned }

      it 'requires planned_at' do
        task.planned_at = nil
        expect(task).to be_invalid
      end

      it 'does not accept finished_at' do
        task.finished_at = DateTime.new(2017, 1, 15)
        expect(task).to be_invalid
      end

      it 'does not accept abandoned_at' do
        task.abandoned_at = DateTime.new(2017, 1, 15)
        expect(task).to be_invalid
      end
    end

    context 'when it is finished' do
      let(:task) { build :task, :finished }

      it 'requires planned_at' do
        task.planned_at = nil
        expect(task).to be_invalid
      end

      it 'requires finished_at' do
        task.finished_at = nil
        expect(task).to be_invalid
      end

      it 'does not accept abandoned_at' do
        task.abandoned_at = DateTime.new(2017, 1, 15)
        expect(task).to be_invalid
      end
    end

    context 'when it is abandoned' do
      let(:task) { build :task, :abandoned }

      it 'does not accept finished_at' do
        task.finished_at = DateTime.new(2017, 1, 15)
        expect(task).to be_invalid
      end

      it 'requires abandoned_at' do
        task.abandoned_at = nil
        expect(task).to be_invalid
      end
    end
  end

  describe '#update_with_transition!' do
    subject { task.update_with_transition! params }

    context 'when executing without state param' do
      let(:task) { create :task, :newed }
      let(:params) { { } }

      it 'fails' do
        expect { subject }
          .to raise_error(Task::InvalidState, /State must be precised/)
      end
    end

    context 'when executing with a unknown state param' do
      let(:task) { create :task, :newed }
      let(:params) { {
        state: 'not_a_state',
      } }

      it 'fails' do
        expect { subject }
          .to raise_error(Task::InvalidState, /'not_a_state' is not a valid state/)
      end
    end

    context 'when starting a newed task' do
      let(:task) { create :task, :newed }
      let(:params) { {
        state: 'started',
      } }

      it 'sets task state to started' do
        expect(subject.reload.state).to eq('started')
      end

      it 'sets started_at attribute to today' do
        expect(subject.reload.started_at).to eq(DateTime.new(2017, 1, 20))
      end
    end

    context 'when trying to start a planned task' do
      let(:task) { create :task, :planned }
      let(:params) { {
        state: 'started',
      } }

      it 'fails' do
        expect { subject }
          .to raise_error(Task::InvalidTransition, /Task cannot transition from 'planned' to 'started'/)
      end
    end

    context 'when trying to start a finished task' do
      let(:task) { create :task, :finished }
      let(:params) { {
        state: 'started',
      } }

      it 'fails' do
        expect { subject }
          .to raise_error(Task::InvalidTransition, /Task cannot transition from 'finished' to 'started'/)
      end
    end

    context 'when trying to start a abandoned task' do
      let(:task) { create :task, :abandoned }
      let(:params) { {
        state: 'started',
      } }

      it 'fails' do
        expect { subject }
          .to raise_error(Task::InvalidTransition, /Task cannot transition from 'abandoned' to 'started'/)
      end
    end

    context 'when planning a newed task' do
      let(:task) { create :task, :newed, planned_count: 0 }
      let(:params) { {
        state: 'planned',
      } }

      it 'sets task state to planned' do
        expect(subject.reload.state).to eq('planned')
      end

      it 'sets planned_at attribute to today' do
        expect(subject.reload.planned_at).to eq(DateTime.new(2017, 1, 20))
      end

      it 'sets started_at attribute to today' do
        expect(subject.reload.started_at).to eq(DateTime.new(2017, 1, 20))
      end

      it 'increments planned_count by 1' do
        expect(subject.reload.planned_count).to eq(1)
      end
    end

    context 'when planning a started task' do
      let(:task) { create :task, :started, planned_count: 0 }
      let(:params) { {
        state: 'planned',
      } }

      it 'sets task state to planned' do
        expect(subject.reload.state).to eq('planned')
      end

      it 'sets planned_at attribute to today' do
        expect(subject.reload.planned_at).to eq(DateTime.new(2017, 1, 20))
      end

      it 'increments planned_count by 1' do
        expect(subject.reload.planned_count).to eq(1)
      end
    end

    context 'when planning a finished task' do
      let(:task) { create :task, :finished, planned_count: 1 }
      let(:params) { {
        state: 'planned',
      } }

      it 'sets task state to planned' do
        expect(subject.reload.state).to eq('planned')
      end

      it 'sets finished_at attribute to nil' do
        expect(subject.reload.finished_at).to be_nil
      end

      it 'sets planned_at attribute to today' do
        expect(subject.reload.planned_at).to eq(DateTime.new(2017, 1, 20))
      end

      it 'increments planned_count by 1' do
        expect(subject.reload.planned_count).to eq(2)
      end
    end

    context 'when replanning a planned task' do
      let(:task) { create :task, :planned, planned_at: 3.days.ago, planned_count: 1 }
      let(:params) { {
        state: 'planned',
      } }

      it 'keeps task state to planned' do
        expect(subject.reload.state).to eq('planned')
      end

      it 'sets planned_at attribute to today' do
        expect(subject.reload.planned_at).to eq(DateTime.new(2017, 1, 20))
      end

      it 'increments planned_count by 1' do
        expect(subject.reload.planned_count).to eq(2)
      end
    end

    context 'when trying to plan a abandoned task' do
      let(:task) { create :task, :abandoned }
      let(:params) { {
        state: 'planned',
      } }

      it 'fails' do
        expect { subject }
          .to raise_error(Task::InvalidTransition, /Task cannot transition from 'abandoned' to 'planned'/)
      end
    end

    context 'when finishing a planned task' do
      let(:task) { create :task, :planned }
      let(:params) { {
        state: 'finished',
      } }

      it 'sets task state to finished' do
        expect(subject.reload.state).to eq('finished')
      end

      it 'sets finished_at attribute to today' do
        expect(subject.reload.finished_at).to eq(DateTime.new(2017, 1, 20))
      end
    end

    context 'when trying to finish a newed task' do
      let(:task) { create :task, :newed }
      let(:params) { {
        state: 'finished',
      } }

      it 'fails' do
        expect { subject }
          .to raise_error(Task::InvalidTransition, /Task cannot transition from 'newed' to 'finished'/)
      end
    end

    context 'when trying to finish a started task' do
      let(:task) { create :task, :started }
      let(:params) { {
        state: 'finished',
      } }

      it 'fails' do
        expect { subject }
          .to raise_error(Task::InvalidTransition, /Task cannot transition from 'started' to 'finished'/)
      end
    end

    context 'when trying to finish a abandoned task' do
      let(:task) { create :task, :abandoned }
      let(:params) { {
        state: 'finished',
      } }

      it 'fails' do
        expect { subject }
          .to raise_error(Task::InvalidTransition, /Task cannot transition from 'abandoned' to 'finished'/)
      end
    end

    context 'when abandoning a newed task' do
      let(:task) { create :task, :newed }
      let(:params) { {
        state: 'abandoned',
      } }

      it 'sets task state to abandoned' do
        expect(subject.reload.state).to eq('abandoned')
      end

      it 'sets abandoned_at attribute to today' do
        expect(subject.reload.abandoned_at).to eq(DateTime.new(2017, 1, 20))
      end
    end

    context 'when abandoning a started task' do
      let(:task) { create :task, :started }
      let(:params) { {
        state: 'abandoned',
      } }

      it 'sets task state to abandoned' do
        expect(subject.reload.state).to eq('abandoned')
      end

      it 'sets abandoned_at attribute to today' do
        expect(subject.reload.abandoned_at).to eq(DateTime.new(2017, 1, 20))
      end
    end

    context 'when abandoning a planned task' do
      let(:task) { create :task, :planned }
      let(:params) { {
        state: 'abandoned',
      } }

      it 'sets task state to abandoned' do
        expect(subject.reload.state).to eq('abandoned')
      end

      it 'sets abandoned_at attribute to today' do
        expect(subject.reload.abandoned_at).to eq(DateTime.new(2017, 1, 20))
      end
    end

    context 'when trying to abandon a finished task' do
      let(:task) { create :task, :finished }
      let(:params) { {
        state: 'abandoned',
      } }

      it 'fails' do
        expect { subject }
          .to raise_error(Task::InvalidTransition, /Task cannot transition from 'finished' to 'abandoned'/)
      end
    end

    context 'when canceling a started task' do
      let(:task) { create :task, :started }
      let(:params) { {
        state: 'newed',
      } }

      it 'sets task state to newed' do
        expect(subject.reload.state).to eq('newed')
      end

      it 'sets started_at attribute to nil' do
        expect(subject.reload.started_at).to be_nil
      end
    end

    context 'when canceling a planned task' do
      let(:task) { create :task, :planned }
      let(:params) { {
        state: 'newed',
      } }

      it 'sets task state to newed' do
        expect(subject.reload.state).to eq('newed')
      end

      it 'sets started_at attribute to nil' do
        expect(subject.reload.started_at).to be_nil
      end

      it 'sets planned_at attribute to nil' do
        expect(subject.reload.planned_at).to be_nil
      end
    end

    context 'when trying to cancel a finished task' do
      let(:task) { create :task, :finished }
      let(:params) { {
        state: 'newed',
      } }

      it 'fails' do
        expect { subject }
          .to raise_error(Task::InvalidTransition, /Task cannot transition from 'finished' to 'newed'/)
      end
    end

    context 'when trying to cancel a abandoned task' do
      let(:task) { create :task, :abandoned }
      let(:params) { {
        state: 'newed',
      } }

      it 'fails' do
        expect { subject }
          .to raise_error(Task::InvalidTransition, /Task cannot transition from 'abandoned' to 'newed'/)
      end
    end
  end

  describe '#sync_state_with_project' do
    before do
      Timecop.freeze DateTime.new(2017)
    end

    after do
      Timecop.return
    end

    context 'when task is newed' do
      let(:task) { build :task, :newed }

      context 'when there are no attached projects' do
        it 'sets task state to started' do
          task.project = nil

          task.sync_state_with_project

          expect(task.state).to eq('started')
          expect(task.started_at).to eq(DateTime.now)
        end
      end

      context 'when attached project is started' do
        it 'sets task state to started' do
          task.project = build(:project, :started)

          task.sync_state_with_project

          expect(task.state).to eq('started')
          expect(task.started_at).to eq(DateTime.now)
        end
      end

      context 'when attached project is NOT started' do
        it 'does not change task state' do
          task.project = build(:project, :newed)

          task.sync_state_with_project

          expect(task.state).to eq('newed')
        end
      end
    end

    context 'when task is started' do
      let(:task) { build :task, :started }

      context 'when there are no attached projects' do
        it 'does not change task state' do
          task.project = nil

          task.sync_state_with_project

          expect(task.state).to eq('started')
        end
      end

      context 'when attached project is started' do
        it 'does not change task state' do
          task.project = build(:project, :started)

          task.sync_state_with_project

          expect(task.state).to eq('started')
        end
      end

      context 'when attached project is NOT started' do
        it 'sets task state to newed' do
          task.project = build(:project, :newed)

          task.sync_state_with_project

          expect(task.state).to eq('newed')
        end
      end
    end

    context 'when task is in another state' do
      let(:task) { build :task, :planned }

      context 'when there are no attached projects' do
        it 'does not change task state' do
          task.project = nil

          task.sync_state_with_project

          expect(task.state).to eq('planned')
        end
      end

      context 'when attached project is started' do
        it 'does not change task state' do
          task.project = build(:project, :started)

          task.sync_state_with_project

          expect(task.state).to eq('planned')
        end
      end

      context 'when attached project is NOT started' do
        it 'does not change task state' do
          task.project = build(:project, :newed)

          task.sync_state_with_project

          expect(task.state).to eq('planned')
        end
      end
    end
  end
end
