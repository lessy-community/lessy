class Api::Users::TasksController < ApplicationController

  def index
    @tasks = current_user.tasks.not_abandoned
  end

  def create
    @task = current_user.tasks.create!(create_task_params)
    render status: :created
  end

private

  def create_task_params
    parameters = fetch_resource_params(:task, [:label], [:due_at, :project_id])
    parameters[:due_at] = parameters[:due_at].to_datetime if parameters.has_key?(:due_at)
    parameters
  end

end
