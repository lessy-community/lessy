class Api::Users::TasksController < ApiController

  def index
    @tasks = current_user.tasks.not_abandoned
  end

  def create
    @task = current_user.tasks.create!(create_task_params)
    render status: :created
  end

private

  def create_task_params
    parameters = fetch_resource_params(:task, [:label], [:planned_at, :project_id])
    parameters[:state] = 'started'
    parameters[:started_at] = DateTime.now
    if parameters.has_key?(:planned_at)
      parameters[:state] = 'planned'
      parameters[:planned_at] = parameters[:planned_at].to_datetime
    end
    parameters
  end

end
