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

  describe 'GET #index' do
    let!(:tasks) { create_list :task, 3, :not_abandoned, user: user }
    let!(:abandoned_task) { create :task, :abandoned, user: user }
    let(:json_response) { JSON.parse(response.body) }

    subject! { get api_tasks_path, headers: { 'Authorization': user.token } }

    it 'succeeds' do
      expect(response).to have_http_status(:ok)
    end

    it 'matches the tasks/index schema' do
      expect(response).to match_response_schema('tasks/index')
    end

    it 'returns the list of non abandoned tasks' do
      expect(json_response.length).to eq(3)
      expect(json_response.map { |t| t['id'] }).not_to include(abandoned_task.id)
    end
  end

  describe 'POST #create' do
    let(:payload) { { label: 'My task', due_at: DateTime.new(2017).to_i } }

    context 'with valid attributes' do
      before do
        post '/api/tasks', params: { task: payload }, headers: { 'Authorization': user.token }, as: :json
      end

      it 'succeeds' do
        expect(response).to have_http_status(:created)
      end

      it 'matches the tasks/task schema' do
        expect(response).to match_response_schema('tasks/task')
      end

      it 'saves the new task' do
        expect(Task.find_by_label('My task')).to be_present
      end

      it 'returns the new project' do
        task = JSON.parse(response.body)
        expect(task['id']).not_to be_nil
        expect(task['label']).to eq('My task')
        expect(task['dueAt']).to eq(DateTime.new(2017).to_i)
      end
    end

    context 'with no due date' do
      before do
        payload.except! :due_at
        post '/api/tasks', params: { task: payload }, headers: { 'Authorization': user.token }, as: :json
      end

      it 'succeeds' do
        expect(response).to have_http_status(:created)
      end

      it 'returns the new project' do
        task = JSON.parse(response.body)
        expect(task['id']).not_to be_nil
        expect(task['label']).to eq('My task')
        expect(task['dueAt']).to eq(0)
      end
    end

    context 'with missing attribute' do
      before do
        post '/api/tasks', params: { task: {} }, headers: { 'Authorization': user.token }, as: :json
      end

      it_behaves_like 'missing param failures', 'Task', 'base'
    end

    context 'with invalid authentication' do
      before do
        post '/api/projects', params: { project: payload }, headers: { 'Authorization': 'not a token' }, as: :json
      end

      it_behaves_like 'failures', :unauthorized, 'custom_error', {
        message: 'Authentication is required',
        code: 'authentication_required',
        resource: 'User',
      }
    end
  end

  describe 'PATCH #update' do
    let(:token) { user.token }
    let(:payload) { {
      label: 'A new label for a task',
      due_at: nil,
    } }
    let(:task) { create :task, label: 'My task', due_at: DateTime.new(2017), user: user }

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
        expect(task.reload.due_at).to be nil
      end
    end

    context 'when authenticated with another user' do
      let(:other_user) { create(:user) }
      let(:token) { other_user.token }

      it_behaves_like 'not found failures', 'Task'
    end
  end

  describe 'POST #finish' do
    let(:task) { create :task, :not_finished, user: user }

    context 'with valid attributes' do
      before do
        post "/api/tasks/#{ task.id }/finish", headers: { 'Authorization': user.token }
      end

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

      before do
        post "/api/tasks/#{ task.id }/finish", headers: { 'Authorization': user.token }
      end

      it_behaves_like 'validation failed failures', 'Task', { base: ['already_finished'] }
    end

    context 'with abandoned task' do
      let(:task) { create :task, :abandoned, user: user }

      before do
        post "/api/tasks/#{ task.id }/finish", headers: { 'Authorization': user.token }
      end

      it_behaves_like 'validation failed failures', 'Task', { base: ['already_abandoned'] }
    end

    context 'when authenticated with another user' do
      let(:other_user) { create :user }

      before do
        post "/api/tasks/#{ task.id }/finish", headers: { 'Authorization': other_user.token }
      end

      it_behaves_like 'not found failures', 'Task'
    end
  end

  describe 'POST #restart' do
    let(:task) { create :task, :finished, restarted_count: 1, user: user }

    context 'with valid attributes' do
      before do
        post "/api/tasks/#{ task.id }/restart", headers: { 'Authorization': user.token }
      end

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

      it 'increments restarted_count' do
        expect(task.reload.restarted_count).to eq(2)
      end
    end

    context 'when authenticated with another user' do
      let(:other_user) { create :user }

      before do
        post "/api/tasks/#{ task.id }/restart", headers: { 'Authorization': other_user.token }
      end

      it_behaves_like 'not found failures', 'Task'
    end
  end

  describe 'POST #start' do
    let(:task) { create :task, :backlogged, user: user }
    let(:token) { user.token }

    subject! { post "/api/tasks/#{ task.id }/start", headers: { 'Authorization': token } }

    context 'with valid task' do
      it 'succeeds' do
        expect(response).to have_http_status(:ok)
      end

      it 'matches the tasks/task schema' do
        expect(response).to match_response_schema('tasks/task')
      end

      it 'sets due_at to today' do
        expect(task.reload.due_at).to eq(DateTime.new(2017))
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

    context 'when authenticated with another user' do
      let(:other_user) { create :user }
      let(:token) { other_user.token }

      it_behaves_like 'not found failures', 'Task'
    end
  end

  describe 'POST #abandon' do
    let(:token) { user.token }
    let(:task) { create :task, :not_finished, user: user }

    subject! { post "/api/tasks/#{ task.id }/abandon", headers: { 'Authorization': token } }

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

    context 'when authenticated with another user' do
      let(:other_user) { create :user }
      let(:token) { other_user.token }

      it_behaves_like 'not found failures', 'Task'
    end
  end

  describe 'POST #order_after' do
    let(:task) { create :task, order: 40, user: user }
    let!(:other_task) { create :task, order: 41, user: user }
    let!(:still_another_task) { create :task, order: 42, user: user }
    let(:payload) { { after_task_id: other_task.id } }
    let(:token) { user.token }

    subject! { post "/api/tasks/#{ task.id }/order_after", params: payload, headers: { 'Authorization': token }, as: :json }

    context 'with valid attributes' do
      it 'succeeds' do
        expect(response).to have_http_status(:ok)
      end

      it 'matches the tasks/order_after schema' do
        expect(response).to match_response_schema('tasks/order_after')
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
