class Api::TasksController < ApplicationController

  def update
    @task = current_task
    @task.update! update_task_params
  end

  def update_state
    @task = current_task

    state = params[:state]
    @task.finish_now! if state == 'finished'
    @task.start! if state == 'started'
    @task.abandon! if state == 'abandoned'
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
    fetch_resource_params(:task, [], [:label])
  end

  def update_task_order_params
    fetch_resource_params(:task, [:order])
  end

end
