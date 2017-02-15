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

  def backlog
    @tasks = current_user.tasks.backlogged
  end

private

  def current_task
    @current_task ||= current_user.tasks.find(params[:id])
  end

  def create_task_params
    parameters = fetch_resource_params(:task, [:label], [:due_at])
    parameters[:due_at] = parameters[:due_at].to_datetime if parameters.has_key?(:due_at)
    parameters.merge(user: current_user)
  end

end
