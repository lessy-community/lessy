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
    @impacted_tasks = if params[:after_task_id].nil?
                        task.order_first!
                      else
                        other_task = current_user.tasks.find(params[:after_task_id])
                        task.order_after! other_task
                      end
  end

private

  def current_task
    @current_task ||= current_user.tasks.find(params[:id])
  end

  def update_task_params
    fetch_resource_params(:task, [], [:label])
  end

end
