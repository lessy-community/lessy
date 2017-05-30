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
    let(:task) { create :task, :finished, user: user }

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
    end

    context 'when authenticated with another user' do
      let(:other_user) { create :user }

      before do
        post "/api/tasks/#{ task.id }/restart", headers: { 'Authorization': other_user.token }
      end

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

  describe 'GET #pending' do
    before do
      create :task, :finished, label: 'finished task', user: user
      create :task, :not_finished, due_at: DateTime.now, label: 'today task', user: user
      create :task, :pending, label: 'pending task', user: user
    end

    context 'with valid authentication' do
      before do
        get '/api/tasks/pending', headers: { 'Authorization': user.token }
      end

      it 'succeeds' do
        expect(response).to have_http_status(:ok)
      end

      it 'matches the tasks/pending schema' do
        expect(response).to match_response_schema('tasks/pending')
      end

      it 'returns pending tasks only' do
        tasks = JSON.parse(response.body)
        expect(tasks.length).to eq(1)
        expect(tasks[0]['label']).to eq('pending task')
      end
    end

    context 'when authenticated with another user' do
      let(:other_user) { create :user }

      before do
        get '/api/tasks/pending', headers: { 'Authorization': other_user.token }
      end

      it 'returns no task' do
        tasks = JSON.parse(response.body)
        expect(tasks.length).to eq(0)
      end
    end
  end

  describe 'GET #backlog' do
    before do
      create :task, :finished, label: 'finished task', user: user
      create :task, :not_finished, due_at: DateTime.now, label: 'today task', user: user
      create :task, :pending, label: 'pending task', user: user
      create :task, :backlogged, label: 'backlogged task', user: user
    end

    context 'with valid authentication' do
      before do
        get '/api/tasks/backlog', headers: { 'Authorization': user.token }
      end

      it 'succeeds' do
        expect(response).to have_http_status(:ok)
      end

      it 'matches the tasks/backlog schema' do
        expect(response).to match_response_schema('tasks/backlog')
      end

      it 'returns backlogged tasks only' do
        tasks = JSON.parse(response.body)
        expect(tasks.length).to eq(1)
        expect(tasks[0]['label']).to eq('backlogged task')
      end
    end

    context 'when authenticated with another user' do
      let(:other_user) { create :user }

      before do
        get '/api/tasks/backlog', headers: { 'Authorization': other_user.token }
      end

      it 'returns no task' do
        tasks = JSON.parse(response.body)
        expect(tasks.length).to eq(0)
      end
    end
  end

end
