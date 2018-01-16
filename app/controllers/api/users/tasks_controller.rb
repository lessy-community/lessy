class Api::Users::TasksController < ApiController

  def index
    @tasks = current_user
      .tasks
      .not_abandoned
      .not_finished_before(2.weeks.ago)
      .order(:id)
      .page(params[:page])
  end

  def create
    @task = current_user.tasks.new(create_task_params)
    @task.sync_state_with_project
    @task.save!
    render status: :created
  end

private

  def create_task_params
    parameters = fetch_resource_params(:task, [:label], [:planned_at, :project_id])
    if parameters.has_key?(:planned_at)
      parameters[:state] = 'planned'
      parameters[:planned_at] = parameters[:planned_at].to_datetime
      parameters[:started_at] = DateTime.now
    else
      parameters[:state] = 'newed'
    end
    parameters
  end

end
