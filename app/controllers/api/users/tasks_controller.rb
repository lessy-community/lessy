class Api::Users::TasksController < ApiController

  def index
    @tasks = current_user
      .tasks
      .not_abandoned
      .not_finished_before(2.weeks.ago)
      .page(params[:page])
  end

  def create
    @task = current_user.tasks.create!(create_task_params)
    render status: :created
  end

private

  def create_task_params
    parameters = fetch_resource_params(:task, [:label], [:planned_at, :project_id])
    project = Project.find(parameters[:project_id]) if parameters.has_key?(:project_id)
    if parameters.has_key?(:planned_at)
      parameters[:state] = 'planned'
      parameters[:planned_at] = parameters[:planned_at].to_datetime
      parameters[:started_at] = DateTime.now
    elsif project.nil? || project.started?
      parameters[:state] = 'started'
      parameters[:started_at] = DateTime.now
    else
      parameters[:state] = 'newed'
    end
    parameters
  end

end
