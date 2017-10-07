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
    let!(:tasks) { create_list :task, 3, :started, user: user }
    let!(:abandoned_task) { create :task, :abandoned, user: user }
    let(:json_response) { JSON.parse(response.body) }

    subject! { get me_tasks_api_users_path, headers: { 'Authorization': user.token } }

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
    let(:payload) { { label: 'My task', planned_at: DateTime.new(2017).to_i } }
    let(:token) { user.token }

    subject! { post me_tasks_api_users_path, params: { task: payload }, headers: { 'Authorization': token }, as: :json }

    context 'with valid attributes' do
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
        expect(task['plannedAt']).to eq(DateTime.new(2017).to_i)
      end
    end

    context 'with project_id' do
      let(:project) { create :project }
      let(:payload) { { label: 'My task', planned_at: DateTime.new(2017).to_i, project_id: project.id } }

      it 'succeeds' do
        expect(response).to have_http_status(:created)
      end

      it 'returns the new task' do
        task = JSON.parse(response.body)
        expect(task['id']).not_to be_nil
        expect(task['label']).to eq('My task')
        expect(task['plannedAt']).to eq(DateTime.new(2017).to_i)
        expect(task['projectId']).to eq(project.id)
      end
    end

    context 'with no due date' do
      let(:payload) { { label: 'My task' } }

      it 'succeeds' do
        expect(response).to have_http_status(:created)
      end

      it 'returns the new task' do
        task = JSON.parse(response.body)
        expect(task['id']).not_to be_nil
        expect(task['label']).to eq('My task')
        expect(task['plannedAt']).to eq(0)
      end
    end

    context 'with missing attribute' do
      let(:payload) { { } }

      it_behaves_like 'missing param failures', 'Task', 'base'
    end

    context 'with invalid authentication' do
      let(:token) { 'not a token' }

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
