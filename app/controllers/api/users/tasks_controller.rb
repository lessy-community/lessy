class Api::Users::TasksController < ApiController
  skip_before_action :require_tos_accepted, only: [:index]

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
    lock_name = "sync_order_for_user_#{current_user.id}"
    Task.with_advisory_lock(lock_name) do
      @task.sync_order
      @task.save!
    end

    NotificationsChannel.broadcast_to(
      current_user,
      action: 'create#tasks',
      id: @task.id,
    )

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
