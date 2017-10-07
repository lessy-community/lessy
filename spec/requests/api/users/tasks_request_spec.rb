require 'rails_helper'
require 'shared_examples_for_failures'

RSpec.describe Api::Users::TasksController, type: :request do

  let(:user) { create :user, :activated }

  before do
    Timecop.freeze DateTime.new(2017)
  end

  after do
    Timecop.return
  end

  describe 'GET #index' do
    let(:json_response) { JSON.parse(response.body) }

    subject { get me_tasks_api_users_path, headers: { 'Authorization': user.token } }

    context 'with less than 50 tasks' do
      let!(:abandoned_task) { create :task, :abandoned, user: user }

      before do
        create_list :task, 3, :started, user: user
        subject
      end

      it 'succeeds' do
        expect(response).to have_http_status(:ok)
      end

      it 'matches the tasks/index schema' do
        expect(response).to match_response_schema('tasks/index')
      end

      it 'returns the list of non abandoned tasks' do
        expect(json_response['data'].length).to eq(3)
        expect(json_response['data'].map { |t| t['id'] }).not_to include(abandoned_task.id)
      end
    end

    context 'with more than 50 tasks' do
      before do
        create_list :task, 55, :started, user: user
        subject
      end

      it 'succeeds and matches the tasks/index schema' do
        expect(response).to have_http_status(:ok)
        expect(response).to match_response_schema('tasks/index')
      end

      it 'returns no more than 50 tasks and sets links' do
        expect(json_response['data'].length).to eq(50)
        expect(json_response['links']['next']).to eq(me_tasks_api_users_path(page: 2))
      end
    end

    context 'with task finished more than 2 weeks ago' do
      let!(:task) { create :task, :finished, user: user, finished_at: 3.weeks.ago }

      before { subject }

      it 'succeeds' do
        expect(response).to have_http_status(:ok)
      end

      it 'matches the tasks/index schema' do
        expect(response).to match_response_schema('tasks/index')
      end

      it 'does not return the task' do
        expect(json_response['data'].map { |t| t['id'] }).not_to include(task.id)
      end
    end

    context 'with no task' do
      before do
        Task.destroy_all
        subject
      end

      it 'does not return next link' do
        expect(json_response['links'].key? 'next').to be_falsey
      end
    end
  end

  describe 'POST #create' do
    let(:payload) { {
      task: {
        label: 'My task',
      },
    } }
    let(:token) { user.token }

    subject { post me_tasks_api_users_path, params: payload,
                                            headers: { 'Authorization': token },
                                            as: :json }

    context 'with minimum attributes' do
      before { subject }

      it 'succeeds' do
        expect(response).to have_http_status(:created)
      end

      it 'matches the tasks/create schema' do
        expect(response).to match_response_schema('tasks/create')
      end

      it 'saves the new task' do
        expect(Task.find_by_label('My task')).to be_present
      end

      it 'returns the new project' do
        task = JSON.parse(response.body)['data']
        expect(task['id']).not_to be_nil
        expect(task['attributes']['label']).to eq('My task')
        expect(task['attributes']['state']).to eq('started')
        expect(task['attributes']['startedAt']).to eq(DateTime.now.to_i)
      end
    end

    context 'with websocket support' do
      it 'sends notification to user' do
        # TODO test notification content as well
        # Problem is we cannot access project created in the controller at the
        # matcher level since subject has not been called yet… so how should we
        # know its id?
        expect { subject }.to have_broadcasted_to(user).from_channel(NotificationsChannel)
      end
    end

    context 'with planned date' do
      let(:payload) { {
        task: {
          label: 'My task',
          planned_at: DateTime.new(2017).to_i,
        },
      } }

      before { subject }

      it 'succeeds' do
        expect(response).to have_http_status(:created)
      end

      it 'returns the new task' do
        task = JSON.parse(response.body)['data']
        expect(task['id']).not_to be_nil
        expect(task['attributes']['label']).to eq('My task')
        expect(task['attributes']['state']).to eq('planned')
        expect(task['attributes']['startedAt']).to eq(DateTime.now.to_i)
        expect(task['attributes']['plannedAt']).to eq(DateTime.new(2017).to_i)
      end
    end

    context 'with not started project' do
      let(:project) { create :project, :newed }
      let(:payload) { {
        task: {
          label: 'My task',
          project_id: project.id,
        },
      } }

      before { subject }

      it 'succeeds' do
        expect(response).to have_http_status(:created)
      end

      it 'returns the new task' do
        task = JSON.parse(response.body)['data']
        expect(task['id']).not_to be_nil
        expect(task['attributes']['label']).to eq('My task')
        expect(task['attributes']['state']).to eq('newed')
        expect(task['relationships']['project']['data']['id']).to eq(project.id)
      end
    end

    context 'with started project' do
      let(:project) { create :project, :started }
      let(:payload) { {
        task: {
          label: 'My task',
          project_id: project.id,
        },
      } }

      before { subject }

      it 'succeeds' do
        expect(response).to have_http_status(:created)
      end

      it 'returns the new task' do
        task = JSON.parse(response.body)['data']
        expect(task['id']).not_to be_nil
        expect(task['attributes']['label']).to eq('My task')
        expect(task['attributes']['state']).to eq('started')
        expect(task['attributes']['startedAt']).to eq(DateTime.now.to_i)
        expect(task['relationships']['project']['data']['id']).to eq(project.id)
      end
    end

    context 'with missing attribute' do
      let(:payload) { {
        task: {
          planned_at: DateTime.new(2017).to_i,
        },
      } }

      before { subject }

      it_behaves_like 'API errors', :unprocessable_entity, {
        errors: [{
          status: '422 Unprocessable Entity',
          code: 'parameter_missing',
          title: 'Parameter is missing',
          detail: 'A parameter is missing or empty but it is required.',
          source: { pointer: '/task/label' },
        }],
      }
    end

    context 'with invalid authentication' do
      let(:token) { 'not a token' }

      before { subject }

      it_behaves_like 'API errors', :unauthorized, {
        errors: [{
          status: '401 Unauthorized',
          code: 'unauthorized',
          title: 'Authentication is required',
          detail: 'Resource you try to reach requires a valid Authentication token.',
        }],
      }
    end
  end

end
