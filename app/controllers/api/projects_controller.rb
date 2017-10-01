class Api::ProjectsController < ApplicationController

  def update
    @project = current_project
    @project.update! update_project_params
  end

  def update_state
    @project = current_project

    state = params[:state]
    @project.start_now! params[:date].to_datetime if state == 'started'
    @project.finish_at! params[:date].to_datetime if state == 'finished'
    @project.stop_now! if state == 'stopped'
  end

private

  def current_project
    @current_project ||= current_user.projects.find(params[:id])
  end

  def update_project_params
    permitted_params = [:name, :description]
    permitted_params << :due_at if current_project.started?
    update_params = params.require(:project).permit(*permitted_params)
    update_params[:due_at] = update_params[:due_at].to_datetime if update_params.has_key? :due_at
    update_params
  end

end
