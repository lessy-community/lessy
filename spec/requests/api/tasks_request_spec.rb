require 'rails_helper'
require 'shared_examples_for_failures'

RSpec.describe Api::TasksController, type: :request do

  let(:user) { create :user, :activated }

  describe 'POST #create' do
    let(:payload) { { label: 'My task' } }

    before do
      Timecop.freeze DateTime.new(2017)
    end

    after do
      Timecop.return
    end

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

      it 'sets due_at to today' do
        task = Task.find(JSON.parse(response.body)['id'])
        expect(task.due_at).to eq(DateTime.new(2017))
      end

      it 'returns the new project' do
        task = JSON.parse(response.body)
        expect(task['id']).not_to be_nil
        expect(task['label']).to eq('My task')
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

  describe 'POST #finish' do
    let(:task) { create :task, :not_finished, user: user }

    before do
      Timecop.freeze DateTime.new(2017)
    end

    after do
      Timecop.return
    end

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

    before do
      Timecop.freeze DateTime.new(2017)
    end

    after do
      Timecop.return
    end

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

end
