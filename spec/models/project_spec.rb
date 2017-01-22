require 'rails_helper'

RSpec.describe Project, type: :model do

  let(:user) { create :user }

  before do
    Timecop.freeze DateTime.new(2017)
  end

  after do
    Timecop.return
  end

  describe 'validation' do
    it 'does not accept due_at before started_at' do
      project = build :project, due_at: DateTime.new(2016),
                                started_at: DateTime.new(2017)
      expect(project).to be_invalid
    end

    it 'does not accept finished_at without started_at' do
      project = build :project, finished_at: DateTime.new(2016)
      expect(project).to be_invalid
    end

    it 'does not accept finished_at before started_at' do
      project = build :project, finished_at: DateTime.new(2016),
                                started_at: DateTime.new(2017)
      expect(project).to be_invalid
    end

    it 'does not accept finished_at after today' do
      project = build :project, finished_at: DateTime.new(2018),
                                started_at: DateTime.new(2017)
      expect(project).to be_invalid
    end

    it 'does not accept stopped_at with started_at' do
      project = build :project, :in_progress, :stopped
      expect(project).to be_invalid
    end

    it 'does not accept names with spaces inside' do
      project = build :project, name: 'invalid name'
      expect(project).to be_invalid
    end

    it 'accepts different names' do
      project = build :project
      names = [
        'name', 'a-name', 'a_name', '-name-', '_name_', '1name42', '---', '42',
        '_____', 'THE-NAME',
      ]

      names.each do |name|
        project.name = name
        expect(project).to be_valid, "#{ name } should be a valid name for a project"
      end
    end
  end

  describe '#start_now!' do
    let(:project) { create :project, :not_started, user: user }
    let(:due_at) { DateTime.new(2018) }

    context 'with less than 3 started projects' do
      it 'succeeds' do
        create_list :project, 2, :in_progress, user: user
        expect { project.start_now! due_at }.not_to raise_error
      end
    end

    context 'with stopped projects' do
      it 'succeeds' do
        project.stop_now!
        expect { project.start_now! due_at }.not_to raise_error
      end
    end

    context 'with finished projects' do
      it 'succeeds' do
        create_list :project, 3, :finished, user: user
        expect { project.start_now! due_at }.not_to raise_error
      end
    end

    context 'with at least 3 started projects' do
      it 'fails' do
        create_list :project, 3, :in_progress, user: user
        expect { project.start_now! due_at }.to raise_error(ActiveRecord::RecordInvalid, /User cannot have more than 3 started projects/)
      end
    end
  end

  describe '#stop_now!' do
    let(:project) { create :project, :in_progress }

    before do
      Timecop.freeze DateTime.new(2017)
      project.stop_now!
    end

    it 'sets started_at to nil' do
      expect(project.started_at).to be_nil
    end

    it 'sets stopped_at to now' do
      expect(project.stopped_at).to eq(DateTime.now)
    end
  end

end
