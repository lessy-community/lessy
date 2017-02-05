class Api::TasksController < ApplicationController

  def create
    @task = Task.create!(create_task_params)
    render status: :created
  end

  def finish
    @task = current_task
    @task.finish_now!
  end

  def restart
    @task = current_task
    @task.restart!
  end

  def pending
    @tasks = current_user.tasks.pending
  end

private

  def current_task
    @current_task ||= current_user.tasks.find(params[:id])
  end

  def create_task_params
    require_resource_params(:task, [:label])
      .merge(user: current_user, due_at: DateTime.now)
  end

end
