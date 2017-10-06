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

  describe 'PATCH #update' do
    let(:token) { user.token }
    let(:payload) { { label: 'A new label for a task' } }
    let(:task) { create :task, label: 'My task', user: user }

    subject! { patch "/api/tasks/#{ task.id }", params: { task: payload }, headers: { 'Authorization': token }, as: :json }

    context 'with valid attributes' do
      it 'succeeds' do
        expect(response).to have_http_status(:ok)
      end

      it 'matches the tasks/task schema' do
        expect(response).to match_response_schema('tasks/task')
      end

      it 'saves the new task' do
        expect(task.reload.label).to eq('A new label for a task')
      end
    end

    context 'when authenticated with another user' do
      let(:other_user) { create(:user) }
      let(:token) { other_user.token }

      it_behaves_like 'not found failures', 'Task'
    end
  end

  describe 'PUT #update_state' do
    let(:token) { user.token }

    before do
      put "/api/tasks/#{ task.id }/state", params: payload, headers: { 'Authorization': token }
    end

    context 'when finishing a task' do
      let(:task) { create :task, :planned, user: user }
      let(:payload) { {
        task: {
          state: 'finished',
        },
      } }

      context 'with valid attributes' do
        it 'succeeds' do
          expect(response).to have_http_status(:ok)
        end

        it 'matches the tasks/task schema' do
          expect(response).to match_response_schema('tasks/task')
        end

        it 'saves finished_at' do
          expect(task.reload.finished_at).to eq(DateTime.new(2017))
        end

        it 'returns the updated task' do
          task = JSON.parse(response.body)
          expect(task['finishedAt']).to eq(DateTime.new(2017).to_i)
        end
      end

      context 'with already finished task' do
        let(:task) { create :task, :finished, user: user }

        it_behaves_like 'invalid transition failures', 'Task', from: 'finished', to: 'finished'
      end

      context 'with abandoned task' do
        let(:task) { create :task, :abandoned, user: user }

        it_behaves_like 'invalid transition failures', 'Task', from: 'abandoned', to: 'finished'
      end
    end

    context 'when replaning a finished task' do
      let(:task) { create :task, :finished, planned_count: 1, user: user }
      let(:payload) { {
        task: {
          state: 'planned',
        },
      } }

      it 'succeeds' do
        expect(response).to have_http_status(:ok)
      end

      it 'matches the tasks/task schema' do
        expect(response).to match_response_schema('tasks/task')
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

      it 'succeeds' do
        expect(response).to have_http_status(:ok)
      end

      it 'matches the tasks/task schema' do
        expect(response).to match_response_schema('tasks/task')
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

      it_behaves_like 'invalid transition failures', 'Task', from: 'abandoned', to: 'started'
    end

    context 'when abandoning a task' do
      let(:task) { create :task, :planned, user: user }
      let(:payload) { {
        task: {
          state: 'abandoned',
        },
      } }

      context 'with valid attributes' do
        it 'succeeds' do
          expect(response).to have_http_status(:ok)
        end

        it 'matches the tasks/task schema' do
          expect(response).to match_response_schema('tasks/task')
        end

        it 'saves abandoned_at' do
          expect(task.reload.abandoned_at).to eq(DateTime.new(2017))
        end

        it 'returns the updated task' do
          task = JSON.parse(response.body)
          expect(task['abandonedAt']).to eq(DateTime.new(2017).to_i)
        end
      end

      context 'with finished task' do
        let(:task) { create :task, :finished, user: user }

        it_behaves_like 'invalid transition failures', 'Task', from: 'finished', to: 'abandoned'
      end

      context 'with abandoned task' do
        let(:task) { create :task, :abandoned, user: user }

        it_behaves_like 'invalid transition failures', 'Task', from: 'abandoned', to: 'abandoned'
      end
    end

    context 'when authenticated with another user' do
      let(:task) { create :task, :planned, user: user }
      let(:payload) { {
        task: {
          state: 'finished',
        },
      } }
      let(:other_user) { create :user }
      let(:token) { other_user.token }

      it_behaves_like 'not found failures', 'Task'
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

    subject! { put order_api_task_path(task.id), params: payload, headers: { 'Authorization': token }, as: :json }

    context 'whith new order lesser than current' do
      let(:payload) { {
        task: {
          order: 40,
        },
      } }

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
    end

    context 'whith new order greater than current' do
      let(:payload) { {
        task: {
          order: 44,
        },
      } }

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
    end

    context 'with missing attribute' do
      let(:payload) { { } }

      it_behaves_like 'missing param failures', 'Task', 'base'
    end

    context 'when authenticated with another user' do
      let(:token) { create(:user).token }
      let(:payload) { {
        task: {
          order: 40,
        },
      } }

      it_behaves_like 'not found failures', 'Task'
    end
  end

end
