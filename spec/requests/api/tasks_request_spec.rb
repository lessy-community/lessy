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
      let(:task) { create :task, :not_finished, user: user }
      let(:payload) { {
        state: 'finished'
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

        it_behaves_like 'validation failed failures', 'Task', { base: ['already_finished'] }
      end

      context 'with abandoned task' do
        let(:task) { create :task, :abandoned, user: user }

        it_behaves_like 'validation failed failures', 'Task', { base: ['already_abandoned'] }
      end
    end

    context 'when starting a finished task' do
      let(:task) { create :task, :finished, started_count: 1, user: user }
      let(:payload) { {
        state: 'started'
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

      it 'sets due_at to today' do
        expect(task.reload.due_at).to eq(DateTime.new(2017))
      end

      it 'increments started_count' do
        expect(task.reload.started_count).to eq(2)
      end
    end

    context 'when starting a backlogged task' do
      let(:task) { create :task, :backlogged, started_count: 0, user: user }
      let(:payload) { {
        state: 'started'
      } }

      it 'succeeds' do
        expect(response).to have_http_status(:ok)
      end

      it 'matches the tasks/task schema' do
        expect(response).to match_response_schema('tasks/task')
      end

      it 'sets due_at to today' do
        expect(task.reload.due_at).to eq(DateTime.new(2017))
      end

      it 'increments started_count' do
        expect(task.reload.started_count).to eq(1)
      end
    end

    context 'when starting an abandoned task' do
      let(:task) { create :task, :abandoned, user: user }
      let(:payload) { {
        state: 'started'
      } }

      it_behaves_like 'validation failed failures', 'Task', { base: ['already_abandoned'] }
    end

    context 'when abandoning a task' do
      let(:task) { create :task, :not_finished, user: user }
      let(:payload) { {
        state: 'abandoned'
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

        it_behaves_like 'validation failed failures', 'Task', { base: ['already_finished'] }
      end

      context 'with abandoned task' do
        let(:task) { create :task, :abandoned, user: user }

        it_behaves_like 'validation failed failures', 'Task', { base: ['already_abandoned'] }
      end
    end

    context 'when authenticated with another user' do
      let(:task) { create :task, :not_finished, user: user }
      let(:payload) { {
        state: 'finished'
      } }
      let(:other_user) { create :user }
      let(:token) { other_user.token }

      it_behaves_like 'not found failures', 'Task'
    end
  end

  describe 'PUT #update_order' do
    let(:task) { create :task, order: 40, user: user }
    let!(:other_task) { create :task, order: 41, user: user }
    let!(:still_another_task) { create :task, order: 42, user: user }
    let(:payload) { { after_task_id: other_task.id } }
    let(:token) { user.token }

    subject! { put "/api/tasks/#{ task.id }/order", params: payload, headers: { 'Authorization': token }, as: :json }

    context 'with valid attributes' do
      it 'succeeds' do
        expect(response).to have_http_status(:ok)
      end

      it 'matches the tasks/update_order schema' do
        expect(response).to match_response_schema('tasks/update_order')
      end

      it 'saves the task' do
        expect(task.reload.order).to eq(42)
      end

      it 'increments tasks strictly after the given one' do
        expect(other_task.reload.order).to eq(41)
        expect(still_another_task.reload.order).to eq(43)
      end
    end

    context 'with after_task_id nil' do
      let(:payload) { { after_task_id: nil } }

      it 'succeeds' do
        expect(response).to have_http_status(:ok)
      end

      it 'sets the order to 1' do
        expect(task.reload.order).to eq(1)
      end

      it 'increments all the other tasks' do
        expect(other_task.reload.order).to eq(42)
        expect(still_another_task.reload.order).to eq(43)
      end
    end

    context 'when other task has been created by another user' do
      let(:other_user) { create(:user) }
      let(:other_task) { create :task, order: 41, user: other_user }

      it_behaves_like 'not found failures', 'Task'
    end

    context 'when authenticated with another user' do
      let(:other_user) { create(:user) }
      let(:token) { other_user.token }

      it_behaves_like 'not found failures', 'Task'
    end
  end

end
