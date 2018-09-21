require 'rails_helper'
require 'shared_examples_for_failures'

RSpec.describe Api::TasksController, type: :request do

  let(:user) { create :user, :activated }

  before do
    Timecop.freeze DateTime.new(2017)
  end

  after do
    Timecop.return
  end

  describe 'GET #show' do
    let(:token) { user.token }
    let(:task) { create :task, user: user }

    subject { get api_task_path(task.id), headers: { 'Authorization': token } }

    context 'with valid token' do
      before { subject }

      it 'succeeds' do
        expect(response).to have_http_status(:ok)
      end

      it 'matches the tasks/show schema' do
        expect(response).to match_response_schema('tasks/show')
      end

      it 'returns the corresponding task' do
        json_task = JSON.parse(response.body)['data']
        expect(json_task['id']).to eq(task.id)
      end
    end

    context 'with invalid authorization' do
      let(:token) { 'not a token' }

      before { subject }

      it_behaves_like 'API errors', :unauthorized, {
        errors: [{
          status: '401 Unauthorized',
          code: 'unauthorized',
          title: 'Authorization is required',
          detail: 'Resource you try to reach requires a valid Authorization token.',
        }],
      }
    end

    context 'with not accepted terms of service' do
      let!(:tos) { create :terms_of_service, :in_the_past }
      let(:user) { create :user, :activated, :not_accepted_tos }

      before { subject }

      it_behaves_like 'API errors', :forbidden, errors: [{
        status: '403 Forbidden',
        code: 'tos_not_accepted',
        title: 'Terms of service not accepted',
        detail: 'Resource you try to reach requires that you accept the terms of service.',
      }]
    end
  end

  describe 'PATCH #update' do
    let(:token) { user.token }
    let(:project) { create :project, :started }
    let(:payload) { {
      task: {
        label: 'A new label for a task',
        project_id: project.id,
      },
    } }
    let(:task) { create :task, :newed, label: 'My task', project: nil, user: user }

    subject { patch api_task_path(task.id), params: payload,
                                            headers: { 'Authorization': token },
                                            as: :json }

    context 'with valid attributes' do
      before { subject }

      it 'succeeds' do
        expect(response).to have_http_status(:ok)
      end

      it 'matches the tasks/update schema' do
        expect(response).to match_response_schema('tasks/update')
      end

      it 'saves the new task' do
        expect(task.reload.label).to eq('A new label for a task')
        expect(task.reload.project).to eq(project)
      end

      it 'changes task state to started' do
        # To know more about state syncing, please have a look at Task#sync_state_with_project
        expect(task.reload.state).to eq('started')
      end
    end

    context 'with websocket support' do
      it 'sends notification to user' do
        expect { subject }.to have_broadcasted_to(user)
          .from_channel(NotificationsChannel)
          .with({
            action: 'update#tasks',
            id: task.id,
            updatedAt: task.updated_at.to_i,
          })
      end
    end

    context 'when authenticated with another user' do
      let(:other_user) { create(:user) }
      let(:token) { other_user.token }

      before { subject }

      it_behaves_like 'API errors', :not_found, {
        errors: [{
          status: '404 Not Found',
          code: 'record_not_found',
          title: 'Record not found',
          detail: 'Record cannot be found, it has been deleted or you may not have access to it.',
          source: { pointer: '/task' },
        }],
      }
    end
  end

  describe 'PUT #update_state' do
    let(:token) { user.token }

    subject { put state_api_task_path(task.id), params: payload,
                                                headers: { 'Authorization': token },
                                                as: :json }

    context 'when finishing a task' do
      let(:task) { create :task, :planned, user: user }
      let(:payload) { {
        task: {
          state: 'finished',
        },
      } }

      context 'with valid attributes' do
        before { subject }

        it 'succeeds' do
          expect(response).to have_http_status(:ok)
        end

        it 'matches the tasks/update_state schema' do
          expect(response).to match_response_schema('tasks/update_state')
        end

        it 'saves finished_at' do
          expect(task.reload.finished_at).to eq(DateTime.new(2017))
        end

        it 'returns the updated task' do
          task = JSON.parse(response.body)['data']
          expect(task['attributes']['finishedAt']).to eq(DateTime.new(2017).in_time_zone.as_json)
        end
      end

      context 'with already finished task' do
        let(:task) { create :task, :finished, user: user }

        before { subject }

        it_behaves_like 'API errors', :unprocessable_entity, {
          errors: [{
            status: '422 Unprocessable Entity',
            code: 'invalid_transition',
            title: 'Invalid transition',
            detail: "Task cannot transition from 'finished' to 'finished'",
            source: { pointer: '/task/state' }
          }]
        }
      end

      context 'with abandoned task' do
        let(:task) { create :task, :abandoned, user: user }

        before { subject }

        it_behaves_like 'API errors', :unprocessable_entity, {
          errors: [{
            status: '422 Unprocessable Entity',
            code: 'invalid_transition',
            title: 'Invalid transition',
            detail: "Task cannot transition from 'abandoned' to 'finished'",
            source: { pointer: '/task/state' }
          }]
        }
      end
    end

    context 'when replaning a finished task' do
      let(:task) { create :task, :finished, planned_count: 1, user: user }
      let(:payload) { {
        task: {
          state: 'planned',
        },
      } }

      before { subject }

      it 'succeeds' do
        expect(response).to have_http_status(:ok)
      end

      it 'matches the tasks/update_state schema' do
        expect(response).to match_response_schema('tasks/update_state')
      end

      it 'resets finished_at' do
        expect(task.reload.finished_at).to be(nil)
      end

      it 'sets planned_at to today' do
        expect(task.reload.planned_at).to eq(DateTime.new(2017))
      end

      it 'increments planned_count' do
        expect(task.reload.planned_count).to eq(2)
      end
    end

    context 'when planning a started task' do
      let(:task) { create :task, :started, planned_count: 0, user: user }
      let(:payload) { {
        task: {
          state: 'planned',
        },
      } }

      before { subject }

      it 'succeeds' do
        expect(response).to have_http_status(:ok)
      end

      it 'matches the tasks/update_state schema' do
        expect(response).to match_response_schema('tasks/update_state')
      end

      it 'sets planned_at to today' do
        expect(task.reload.planned_at).to eq(DateTime.new(2017))
      end

      it 'increments planned_count' do
        expect(task.reload.planned_count).to eq(1)
      end
    end

    context 'when starting an abandoned task' do
      let(:task) { create :task, :abandoned, user: user }
      let(:payload) { {
        task: {
          state: 'started',
        },
      } }

      before { subject }

      it_behaves_like 'API errors', :unprocessable_entity, {
        errors: [{
          status: '422 Unprocessable Entity',
          code: 'invalid_transition',
          title: 'Invalid transition',
          detail: "Task cannot transition from 'abandoned' to 'started'",
          source: { pointer: '/task/state' }
        }]
      }
    end

    context 'when abandoning a task' do
      let(:task) { create :task, :planned, user: user }
      let(:payload) { {
        task: {
          state: 'abandoned',
        },
      } }

      context 'with valid attributes' do
        before { subject }

        it 'succeeds' do
          expect(response).to have_http_status(:ok)
        end

        it 'matches the tasks/update_state schema' do
          expect(response).to match_response_schema('tasks/update_state')
        end

        it 'saves abandoned_at' do
          expect(task.reload.abandoned_at).to eq(DateTime.new(2017))
        end

        it 'returns the updated task' do
          task = JSON.parse(response.body)['data']
          expect(task['attributes']['abandonedAt']).to eq(DateTime.new(2017).in_time_zone.as_json)
        end
      end

      context 'with finished task' do
        let(:task) { create :task, :finished, user: user }

        before { subject }

        it_behaves_like 'API errors', :unprocessable_entity, {
          errors: [{
            status: '422 Unprocessable Entity',
            code: 'invalid_transition',
            title: 'Invalid transition',
            detail: "Task cannot transition from 'finished' to 'abandoned'",
            source: { pointer: '/task/state' }
          }]
        }
      end

      context 'with abandoned task' do
        let(:task) { create :task, :abandoned, user: user }

        before { subject }

        it_behaves_like 'API errors', :unprocessable_entity, {
          errors: [{
            status: '422 Unprocessable Entity',
            code: 'invalid_transition',
            title: 'Invalid transition',
            detail: "Task cannot transition from 'abandoned' to 'abandoned'",
            source: { pointer: '/task/state' }
          }]
        }
      end
    end

    context 'with websocket support' do
      let(:task) { create :task, :started, user: user }
      let(:payload) { {
        task: {
          state: 'planned',
        },
      } }

      it 'sends notification to user' do
        expect { subject }.to have_broadcasted_to(user)
          .from_channel(NotificationsChannel)
          .with({
            action: 'update#tasks',
            id: task.id,
            updatedAt: task.updated_at.to_i,
          })
      end
    end

    context 'when authenticated with another user' do
      let(:task) { create :task, :planned, user: user }
      let(:payload) { {
        task: {
          state: 'finished',
        },
      } }
      let(:token) { create(:user).token }

      before { subject }

      it_behaves_like 'API errors', :not_found, {
        errors: [{
          status: '404 Not Found',
          code: 'record_not_found',
          title: 'Record not found',
          detail: 'Record cannot be found, it has been deleted or you may not have access to it.',
          source: { pointer: '/task' },
        }],
      }
    end
  end

  describe 'PUT #update_order' do
    let!(:task1) { create :task, order: 40, user: user }
    let!(:task2) { create :task, order: 41, user: user }
    let!(:task3) { create :task, order: 42, user: user }
    let!(:task4) { create :task, order: 43, user: user }
    let!(:task5) { create :task, order: 44, user: user }
    let(:token) { user.token }
    let(:task) { task3 }

    subject { put order_api_task_path(task.id), params: payload,
                                                headers: { 'Authorization': token },
                                                as: :json }

    context 'whith new order lesser than current' do
      let(:payload) { {
        task: {
          order: 40,
        },
      } }

      before { subject }

      it 'succeeds' do
        expect(response).to have_http_status(:ok)
      end

      it 'matches the tasks/update_order schema' do
        expect(response).to match_response_schema('tasks/update_order')
      end

      it 'saves the task' do
        expect(task.reload.order).to eq(40)
      end

      it 'increments tasks strictly after the given one' do
        expect(task1.reload.order).to eq(41)
        expect(task2.reload.order).to eq(42)
        expect(task4.reload.order).to eq(43)
        expect(task5.reload.order).to eq(44)
      end

      it 'returns impacted tasks' do
        impacted_tasks = JSON.parse(response.body)['data'].map do |task|
          [task['id'], task['attributes']['order']]
        end

        expect(impacted_tasks).to contain_exactly(
          [task1.id, task1.reload.order],
          [task2.id, task2.reload.order],
          [task.id, task.reload.order]
        )
      end
    end

    context 'whith new order greater than current' do
      let(:payload) { {
        task: {
          order: 44,
        },
      } }

      before { subject }

      it 'succeeds' do
        expect(response).to have_http_status(:ok)
      end

      it 'matches the tasks/update_order schema' do
        expect(response).to match_response_schema('tasks/update_order')
      end

      it 'saves the task' do
        expect(task.reload.order).to eq(44)
      end

      it 'increments tasks strictly after the given one' do
        expect(task1.reload.order).to eq(40)
        expect(task2.reload.order).to eq(41)
        expect(task4.reload.order).to eq(42)
        expect(task5.reload.order).to eq(43)
      end

      it 'returns impacted tasks' do
        impacted_tasks = JSON.parse(response.body)['data'].map do |task|
          [task['id'], task['attributes']['order']]
        end

        expect(impacted_tasks).to contain_exactly(
          [task.id, task.reload.order],
          [task4.id, task4.reload.order],
          [task5.id, task5.reload.order]
        )
      end
    end

    context 'with missing attribute' do
      let(:payload) { { } }

      before { subject }

      it_behaves_like 'API errors', :unprocessable_entity, {
        errors: [{
          status: '422 Unprocessable Entity',
          code: 'parameter_missing',
          title: 'Parameter is missing',
          detail: 'A parameter is missing or empty but it is required.',
          source: { pointer: '/task' },
        }],
      }
    end

    context 'when authenticated with another user' do
      let(:token) { create(:user).token }
      let(:payload) { {
        task: {
          order: 40,
        },
      } }

      before { subject }

      it_behaves_like 'API errors', :not_found, {
        errors: [{
          status: '404 Not Found',
          code: 'record_not_found',
          title: 'Record not found',
          detail: 'Record cannot be found, it has been deleted or you may not have access to it.',
          source: { pointer: '/task' },
        }],
      }
    end
  end

end
