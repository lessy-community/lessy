class Api::TasksController < ApiController

  def update
    @task = current_task
    @task.assign_attributes update_task_params
    @task.sync_state_with_project
    @task.save!
  end

  def update_state
    @task = current_task
    @task.update_with_transition! update_task_state_params
  end

  def update_order
    task = current_task
    order = update_task_order_params[:order]
    @impacted_tasks = []
    @impacted_tasks = task.order_incremental!(order) if order < task.order
    @impacted_tasks = task.order_decremental!(order) if order > task.order
  end

private

  def current_task
    @current_task ||= current_user.tasks.find(params[:id])
  end

  def update_task_params
    fetch_resource_params(:task, [], [:label, :project_id])
  end

  def update_task_order_params
    fetch_resource_params(:task, [:order])
  end

  def update_task_state_params
    fetch_resource_params(:task, [:state])
  end

end
