class Api::TasksController < ApplicationController

  def create
    @task = Task.create!(create_task_params)
    render status: :created
  end

private

  def create_task_params
    require_resource_params(:task, [:label])
      .merge(user: current_user, due_at: DateTime.now)
  end

end
