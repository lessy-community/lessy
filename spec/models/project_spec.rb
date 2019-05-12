require 'rails_helper'

RSpec.describe Project, type: :model do

  let(:user) { create :user }

  before do
    Timecop.freeze Time.new(2017, 1, 20).utc
  end

  after do
    Timecop.return
  end

  describe '#state' do
    context 'when it is newed' do
      let(:project) { build :project, :newed }

      it 'does not accept started_at' do
        project.started_at = Time.new(2017, 1, 1).utc
        expect(project).to be_invalid
      end

      it 'does not accept paused_at' do
        project.paused_at = Time.new(2017, 1, 15).utc
        expect(project).to be_invalid
      end

      it 'does not accept due_at' do
        project.due_at = Time.new(2017, 2, 20).utc
        expect(project).to be_invalid
      end

      it 'does not accept finished_at' do
        project.finished_at = Time.new(2017, 1, 15).utc
        expect(project).to be_invalid
      end
    end

    context 'when it is started' do
      let(:project) { build :project, :started }

      it 'requires started_at' do
        project.started_at = nil
        expect(project).to be_invalid
      end

      it 'requires due_at' do
        project.due_at = nil
        expect(project).to be_invalid
      end

      it 'requires due_at greater than started_at' do
        project.due_at = Time.new(2017, 1, 1).utc
        project.started_at = Time.new(2017, 1, 15).utc
        expect(project).to be_invalid
      end

      it 'does not accept paused_at' do
        project.paused_at = Time.new(2017, 1, 15).utc
        expect(project).to be_invalid
      end

      it 'does not accept finished_at' do
        project.finished_at = Time.new(2017, 1, 15).utc
        expect(project).to be_invalid
      end
    end

    context 'when it is paused' do
      let(:project) { build :project, :paused }

      it 'requires started_at' do
        project.started_at = nil
        expect(project).to be_invalid
      end

      it 'requires paused_at' do
        project.paused_at = nil
        expect(project).to be_invalid
      end

      it 'requires paused_at greater than started_at' do
        project.paused_at = Time.new(2017, 1, 1).utc
        project.started_at = Time.new(2017, 1, 15).utc
        expect(project).to be_invalid
      end

      it 'requires due_at greater than started_at' do
        project.due_at = Time.new(2017, 1, 1).utc
        project.started_at = Time.new(2017, 1, 15).utc
        expect(project).to be_invalid
      end

      it 'does not accept finished_at' do
        project.finished_at = Time.new(2017, 1, 15).utc
        expect(project).to be_invalid
      end
    end

    context 'when it is finished' do
      let(:project) { build :project, :finished }

      it 'requires started_at' do
        project.started_at = nil
        expect(project).to be_invalid
      end

      it 'requires finished_at' do
        project.finished_at = nil
        expect(project).to be_invalid
      end

      it 'requires due_at greater than started_at' do
        project.due_at = Time.new(2017, 1, 1).utc
        project.started_at = Time.new(2017, 1, 15).utc
        expect(project).to be_invalid
      end

      it 'requires finished_at greater than started_at' do
        project.finished_at = Time.new(2017, 1, 1).utc
        project.started_at = Time.new(2017, 1, 15).utc
        expect(project).to be_invalid
      end

      it 'requires finished_at lesser or equal to today' do
        project.finished_at = 1.day.from_now
        expect(project).to be_invalid
      end

      it 'does not accept paused_at' do
        project.paused_at = Time.new(2017, 1, 15).utc
        expect(project).to be_invalid
      end
    end
  end

  describe '#update_with_transition!' do
    subject { project.update_with_transition! params }

    context 'when executing without state param' do
      let(:project) { create :project, :newed }
      let(:params) { { } }

      it 'fails' do
        expect { subject }
          .to raise_error(Project::InvalidState, /State must be precised/)
      end
    end

    context 'when executing with a unknown state param' do
      let(:project) { create :project, :newed }
      let(:params) { {
        state: 'not_a_state',
      } }

      it 'fails' do
        expect { subject }
          .to raise_error(Project::InvalidState, /'not_a_state' is not a valid state/)
      end
    end

    context 'when trying to new a started project' do
      let(:project) { create :project, :started }
      let(:params) { {
        state: 'newed',
      } }

      it 'fails' do
        expect { subject }
          .to raise_error(Project::InvalidTransition, /Project cannot transition from 'started' to 'newed'/)
      end
    end

    context 'when trying to new a paused project' do
      let(:project) { create :project, :paused }
      let(:params) { {
        state: 'newed',
      } }

      it 'fails' do
        expect { subject }
          .to raise_error(Project::InvalidTransition, /Project cannot transition from 'paused' to 'newed'/)
      end
    end

    context 'when trying to new a finished project' do
      let(:project) { create :project, :finished }
      let(:params) { {
        state: 'newed',
      } }

      it 'fails' do
        expect { subject }
          .to raise_error(Project::InvalidTransition, /Project cannot transition from 'finished' to 'newed'/)
      end
    end

    context 'when starting a newed project' do
      let(:project) { create :project, :newed }
      let(:params) { {
        state: 'started',
        due_at: Time.new(2017, 2, 20).utc,
      } }

      it 'sets project state to started' do
        expect(subject.reload.state).to eq('started')
      end

      it 'updates due_at attribute' do
        expect(subject.reload.due_at).to eq(Time.new(2017, 2, 20).utc)
      end

      it 'sets started_at attribute to today' do
        expect(subject.reload.started_at).to eq(Time.new(2017, 1, 20).utc)
      end
    end

    context 'when trying to start a newed project with already 3 started project' do
      let!(:projects) { create_list :project, 3, :started, user: user }
      let(:project) { create :project, :newed, user: user }
      let(:params) { {
        state: 'started',
        due_at: Time.new(2017, 2, 20).utc,
      } }

      it 'fails' do
        expect { subject }
          .to raise_error(Project::ForbiddenTransition, /User cannot have more than 3 started projects/)
      end
    end

    context 'when trying to start a finished project' do
      let(:project) { create :project, :finished }
      let(:params) { {
        state: 'started',
      } }

      it 'fails' do
        expect { subject }
          .to raise_error(Project::InvalidTransition, /Project cannot transition from 'finished' to 'started'/)
      end
    end

    context 'when pausing a started project' do
      let(:project) { create :project, :started }
      let(:params) { {
        state: 'paused',
      } }

      it 'sets project state to paused' do
        expect(subject.reload.state).to eq('paused')
      end

      it 'sets paused_at attribute to today' do
        expect(subject.reload.paused_at).to eq(Time.new(2017, 1, 20).utc)
      end
    end

    context 'when trying to pause a newed project' do
      let(:project) { create :project, :newed }
      let(:params) { {
        state: 'paused',
      } }

      it 'fails' do
        expect { subject }
          .to raise_error(Project::InvalidTransition, /Project cannot transition from 'newed' to 'paused'/)
      end
    end

    context 'when trying to pause a finished project' do
      let(:project) { create :project, :finished }
      let(:params) { {
        state: 'paused',
      } }

      it 'fails' do
        expect { subject }
          .to raise_error(Project::InvalidTransition, /Project cannot transition from 'finished' to 'paused'/)
      end
    end

    context 'when restarting a paused project' do
      let(:project) { create :project, :paused, started_at: Time.new(2017, 1, 1).utc }
      let(:params) { {
        state: 'started',
      } }

      it 'sets project state to started' do
        expect(subject.reload.state).to eq('started')
      end

      it 'sets paused_at attribute to nil' do
        expect(subject.reload.paused_at).to be_nil
      end

      it 'does not change started_at attribute' do
        expect(subject.reload.started_at).to eq(Time.new(2017, 1, 1).utc)
      end
    end

    context 'when trying to restart a paused project with already 3 started project' do
      let!(:projects) { create_list :project, 3, :started, user: user }
      let(:project) { create :project, :paused, user: user }
      let(:params) { {
        state: 'started',
      } }

      it 'fails' do
        expect { subject }
          .to raise_error(Project::ForbiddenTransition, /User cannot have more than 3 started projects/)
      end
    end

    context 'when finishing a started project' do
      let(:project) { create :project, :started, started_at: Time.new(2017, 1, 1).utc }
      let(:params) { {
        state: 'finished',
        finished_at: Time.new(2017, 1, 15).utc,
      } }

      it 'sets project state to finished' do
        expect(subject.reload.state).to eq('finished')
      end

      it 'updates finished_at attribute' do
        expect(subject.reload.finished_at).to eq(Time.new(2017, 1, 15).utc)
      end

      it 'does not change started_at' do
        expect(subject.reload.started_at).to eq(Time.new(2017, 1, 1).utc)
      end
    end

    context 'when trying to finish a newed project' do
      let(:project) { create :project, :newed }
      let(:params) { {
        state: 'finished',
      } }

      it 'fails' do
        expect { subject }
          .to raise_error(Project::InvalidTransition, /Project cannot transition from 'newed' to 'finished'/)
      end
    end

    context 'when trying to finish a paused project' do
      let(:project) { create :project, :paused }
      let(:params) { {
        state: 'finished',
      } }

      it 'fails' do
        expect { subject }
          .to raise_error(Project::InvalidTransition, /Project cannot transition from 'paused' to 'finished'/)
      end
    end
  end

end
