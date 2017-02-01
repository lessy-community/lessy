require 'rails_helper'
require 'shared_examples_for_failures'

RSpec.describe Api::ProjectsController, type: :request do

  let(:user) { create :user, :activated }

  describe 'POST #create' do
    context 'with valid attributes' do
      before do
        payload = { name: 'my-project' }
        post '/api/projects', params: { project: payload }, headers: { 'Authorization': user.token }, as: :json
      end

      it 'succeeds' do
        expect(response).to have_http_status(:created)
      end

      it 'matches the projects/project schema' do
        expect(response).to match_response_schema('projects/project')
      end

      it 'saves the new project' do
        expect(Project.find_by(name: 'my-project')).to be_present
      end

      it 'returns the new project' do
        project = JSON.parse(response.body)
        expect(project['id']).not_to be_nil
        expect(project['name']).to eq('my-project')
        expect(project['isInProgress']).to be false
      end
    end

    context 'with missing attribute' do
      before do
        post '/api/projects', params: { project: {} }, headers: { 'Authorization': user.token }, as: :json
      end

      it_behaves_like 'missing param failures', 'Project', 'base'
    end

    context 'with invalid name' do
      before do
        payload = { name: 'An invalid name' }
        post '/api/projects', params: { project: payload }, headers: { 'Authorization': user.token }, as: :json
      end

      it_behaves_like 'validation failed failures', 'Project', { name: ['invalid'] }
    end

    context 'with existing project' do
      before do
        create :project, user: user, name: 'my-project'
        payload = { name: 'my-project' }
        post '/api/projects', params: { project: payload }, headers: { 'Authorization': user.token }, as: :json
      end

      it_behaves_like 'validation failed failures', 'Project', { name: ['taken'] }
    end

    context 'with invalid authentication' do
      before do
        payload = { name: 'my-project' }
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
    let(:project) { create :project, :in_progress, user: user,
                                                   name: 'my-project',
                                                   description: 'Old description' }
    let(:payload) { {
      name: 'new-name-for-a-project',
      description: 'New description',
      due_at: DateTime.new(2018, 1, 20).to_i,
    } }

    context 'with valid attributes' do
      before do
        patch "/api/projects/#{project.id}", params: { project: payload }, headers: { 'Authorization': user.token }, as: :json
      end

      it 'succeeds' do
        expect(response).to have_http_status(:ok)
      end

      it 'matches the projects/project schema' do
        expect(response).to match_response_schema('projects/project')
      end

      it 'saves the new project' do
        project.reload
        expect(project.name).to eq('new-name-for-a-project')
        expect(project.description).to eq('New description')
        expect(project.due_at).to eq(DateTime.new(2018, 1, 20))
      end

      it 'returns the new project' do
        api_project = JSON.parse(response.body)
        expect(api_project['id']).to eq(project.id)
        expect(api_project['name']).to eq('new-name-for-a-project')
        expect(api_project['description']).to eq('New description')
        expect(api_project['dueAt']).to eq(DateTime.new(2018, 1, 20).to_i)
      end
    end

    context 'with invalid name' do
      before do
        payload[:name] = 'an invalid name'
        patch "/api/projects/#{project.id}", params: { project: payload }, headers: { 'Authorization': user.token }, as: :json
      end

      it_behaves_like 'validation failed failures', 'Project', { name: ['invalid'] }
    end

    context 'with not started project' do
      let(:not_started_project) { create :project, :not_started, user: user }

      before do
        patch "/api/projects/#{not_started_project.id}", params: { project: payload }, headers: { 'Authorization': user.token }, as: :json
      end

      it 'succeeds' do
        expect(response).to have_http_status(:ok)
      end

      it 'does not change due_at' do
        expect(not_started_project.reload.due_at).to be_nil
      end
    end

    context 'with missing attribute' do
      before do
        patch "/api/projects/#{project.id}", params: { }, headers: { 'Authorization': user.token }, as: :json
      end

      it_behaves_like 'missing param failures', 'Project', 'base'
    end

    context 'with unknown project' do
      before do
        Project.destroy_all
        patch '/api/projects/42', params: { project: payload }, headers: { 'Authorization': user.token }, as: :json
      end

      it_behaves_like 'not found failures', 'Project'
    end

    context 'when authenticated with another user' do
      let(:other_user) { create :user }

      before do
        patch "/api/projects/#{project.id}", params: { project: payload }, headers: { 'Authorization': other_user.token }, as: :json
      end

      it_behaves_like 'not found failures', 'Project'
    end

    context 'with invalid authentication' do
      before do
        patch "/api/projects/#{project.id}", params: { project: payload }, headers: { 'Authorization': 'not a token' }, as: :json
      end

      it_behaves_like 'failures', :unauthorized, 'custom_error', {
        message: 'Authentication is required',
        code: 'authentication_required',
        resource: 'User',
      }
    end
  end

  describe 'GET #find' do
    let(:user) { create :user, :activated, username: 'john' }

    before do
      @project = create(:project, user: user, name: 'my-project')
    end

    context 'when looking for own existing project' do
      before do
        get '/api/users/john/projects/my-project', headers: { 'Authorization': user.token }
      end

      it 'succeeds' do
        expect(response).to have_http_status(:ok)
      end

      it 'matches the projects/project schema' do
        expect(response).to match_response_schema('projects/project')
      end

      it 'returns the corresponding project' do
        json_project = JSON.parse(response.body)
        expect(json_project['id']).to eq(@project.id)
      end
    end

    context 'when looking for own existing project by user id' do
      before do
        get "/api/users/#{ user.id }/projects/my-project", headers: { 'Authorization': user.token }
      end

      it 'succeeds' do
        expect(response).to have_http_status(:ok)
      end

      it 'matches the projects/project schema' do
        expect(response).to match_response_schema('projects/project')
      end

      it 'returns the corresponding project' do
        json_project = JSON.parse(response.body)
        expect(json_project['id']).to eq(@project.id)
      end
    end

    context 'when authenticated with another user' do
      let(:other_user) { create :user }

      before do
        get '/api/users/john/projects/my-project', headers: { 'Authorization': other_user.token }
      end

      it_behaves_like 'not found failures', 'User'
    end

    context 'when looking for a missing project' do
      before do
        @project.destroy
        get '/api/users/john/projects/my-project', headers: { 'Authorization': user.token }
      end

      it_behaves_like 'not found failures', 'Project'
    end
  end

  describe 'POST #start' do
    let(:project) { create :project, :not_started, user: user }
    let(:payload) { { project: { due_at: DateTime.new(2017, 01, 20, 14).to_i } } }

    before do
      Timecop.freeze DateTime.new(2017)
    end

    after do
      Timecop.return
    end

    context 'with valid attributes' do
      before do
        post "/api/projects/#{ project.id }/start", params: payload, headers: { 'Authorization': user.token }, as: :json
      end

      it 'succeeds' do
        expect(response).to have_http_status(:ok)
      end

      it 'matches the projects/project schema' do
        expect(response).to match_response_schema('projects/project')
      end

      it 'saves due_at' do
        expect(project.reload.due_at).to eq(DateTime.new(2017, 1, 20, 14))
      end

      it 'sets started_at to now' do
        expect(project.reload.started_at).to eq(DateTime.new(2017))
      end

      it 'returns the updated project' do
        project = JSON.parse(response.body)
        expect(project['dueAt']).to eq(1484920800)
        expect(project['startedAt']).to eq(1483228800)
        expect(project['isInProgress']).to be true
      end
    end

    context 'with a stopped project' do
      before do
        project.stop_now!
        post "/api/projects/#{ project.id }/start", params: payload, headers: { 'Authorization': user.token }, as: :json
      end

      it 'succeeds' do
        expect(response).to have_http_status(:ok)
      end

      it 'sets stopped_at to nil' do
        expect(project.reload.stopped_at).to be_nil
      end
    end

    context 'with missing attribute' do
      before do
        post "/api/projects/#{ project.id }/start", params: { project: { due_at: nil } }, headers: { 'Authorization': user.token }, as: :json
      end

      it_behaves_like 'missing param failures', 'Project', 'due_at'
    end

    context 'with already started project' do
      before do
        project.start_now! 15.days.from_now
        post "/api/projects/#{ project.id }/start", params: payload, headers: { 'Authorization': user.token }, as: :json
      end

      it_behaves_like 'validation failed failures', 'Project', { base: ['already_started'] }
    end

    context 'with already 3 in_progress projects' do
      before do
        create_list :project, 3, :in_progress, user: user
        post "/api/projects/#{ project.id }/start", params: payload, headers: { 'Authorization': user.token }, as: :json
      end

      it_behaves_like 'validation failed failures', 'Project', { base: ['reached_max_started'] }
    end

    context 'with invalid due_at' do
      before do
        payload[:project][:due_at] = DateTime.new(2016, 12, 31).to_i
        post "/api/projects/#{ project.id }/start", params: payload, headers: { 'Authorization': user.token }, as: :json
      end

      it_behaves_like 'validation failed failures', 'Project', { dueAt: ['before_started_at'] }
    end

    context 'when authenticated with another user' do
      let(:other_user) { create :user }

      before do
        post "/api/projects/#{ project.id }/start", params: payload, headers: { 'Authorization': other_user.token }, as: :json
      end

      it_behaves_like 'not found failures', 'Project'
    end
  end

  describe 'POST #finish' do
    let(:project) { create :project, :in_progress, user: user, started_at: DateTime.new(2017) }
    let(:payload) { { project: { finished_at: DateTime.new(2017, 01, 20).to_i } } }

    before do
      Timecop.freeze DateTime.new(2017, 1, 30)
    end

    after do
      Timecop.return
    end

    context 'with valid attributes' do
      before do
        post "/api/projects/#{ project.id }/finish", params: payload, headers: { 'Authorization': user.token }, as: :json
      end

      it 'succeeds' do
        expect(response).to have_http_status(:ok)
      end

      it 'matches the projects/project schema' do
        expect(response).to match_response_schema('projects/project')
      end

      it 'saves finished_at' do
        expect(project.reload.finished_at).to eq(DateTime.new(2017, 1, 20))
      end

      it 'returns the updated project' do
        project = JSON.parse(response.body)
        expect(project['finishedAt']).to eq(DateTime.new(2017, 01, 20).to_i)
      end
    end

    context 'with missing attribute' do
      before do
        post "/api/projects/#{ project.id }/finish", params: { project: { finished_at: nil } }, headers: { 'Authorization': user.token }, as: :json
      end

      it_behaves_like 'missing param failures', 'Project', 'finished_at'
    end

    context 'with already finished project' do
      before do
        project.finish_at! DateTime.new(2017, 01, 15)
        post "/api/projects/#{ project.id }/finish", params: payload, headers: { 'Authorization': user.token }, as: :json
      end

      it_behaves_like 'validation failed failures', 'Project', { base: ['already_finished'] }
    end

    context 'with a finish date in the future' do
      before do
        payload[:project][:finished_at] = 15.days.from_now.to_i
        post "/api/projects/#{ project.id }/finish", params: payload, headers: { 'Authorization': user.token }, as: :json
      end

      it_behaves_like 'validation failed failures', 'Project', { finishedAt: ['outside_started_at_and_today'] }
    end

    context 'with a finish date before started_at' do
      before do
        payload[:project][:finished_at] = DateTime.new(2016).to_i
        post "/api/projects/#{ project.id }/finish", params: payload, headers: { 'Authorization': user.token }, as: :json
      end

      it_behaves_like 'validation failed failures', 'Project', { finishedAt: ['outside_started_at_and_today'] }
    end

    context 'when authenticated with another user' do
      let(:other_user) { create :user }

      before do
        post "/api/projects/#{ project.id }/finish", params: payload, headers: { 'Authorization': other_user.token }, as: :json
      end

      it_behaves_like 'not found failures', 'Project'
    end
  end

  describe 'GET #get_finished' do
    let(:user) { create :user, :activated, username: 'john' }

    before do
      @project = create(:project, :finished, user: user, name: 'my-project')
    end

    context 'when looking for own existing project' do
      before do
        get '/api/users/john/finished', headers: { 'Authorization': user.token }
      end

      it 'succeeds' do
        expect(response).to have_http_status(:ok)
      end

      it 'matches the projects/project schema' do
        expect(response).to match_response_schema('projects/get_finished')
      end

      it 'returns the corresponding project' do
        projects = JSON.parse(response.body)
        expect(projects.length).to eq(1)
        expect(projects[0]['id']).to eq(@project.id)
      end
    end

    context 'when authenticated with another user' do
      let(:other_user) { create :user }

      before do
        get '/api/users/john/finished', headers: { 'Authorization': other_user.token }
      end

      it_behaves_like 'not found failures', 'User'
    end
  end

  describe 'POST #stop' do
    let(:project) { create :project, :in_progress, user: user, started_at: DateTime.new(2017) }

    before do
      Timecop.freeze DateTime.new(2017, 1, 30)
    end

    after do
      Timecop.return
    end

    context 'with valid project' do
      before do
        post "/api/projects/#{ project.id }/stop", headers: { 'Authorization': user.token }
      end

      it 'succeeds' do
        expect(response).to have_http_status(:ok)
      end

      it 'matches the projects/project schema' do
        expect(response).to match_response_schema('projects/project')
      end

      it 'saves stopped_at' do
        expect(project.reload.stopped_at).to eq(DateTime.new(2017, 1, 30))
      end

      it 'returns the updated project' do
        project = JSON.parse(response.body)
        expect(project['stoppedAt']).to eq(DateTime.new(2017, 01, 30).to_i)
      end
    end

    context 'with already stopped project' do
      before do
        project.stop_now!
        post "/api/projects/#{ project.id }/stop", headers: { 'Authorization': user.token }
      end

      it_behaves_like 'validation failed failures', 'Project', { base: ['already_stopped'] }
    end

    context 'with already finished project' do
      before do
        project.finish_at! DateTime.new(2017, 01, 15)
        post "/api/projects/#{ project.id }/stop", headers: { 'Authorization': user.token }
      end

      it_behaves_like 'validation failed failures', 'Project', { base: ['already_finished'] }
    end

    context 'when authenticated with another user' do
      let(:other_user) { create :user }

      before do
        post "/api/projects/#{ project.id }/stop", headers: { 'Authorization': other_user.token }
      end

      it_behaves_like 'not found failures', 'Project'
    end
  end

end
