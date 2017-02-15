class Api::ProjectsController < ApplicationController

  def create
    @project = Project.create!(create_project_params)
    render status: :created
  end

  def update
    @project = current_project
    @project.update! update_project_params
  end

  def find
    user = User.find_by_identifier!(params[:id])

    # Note: for the moment, projects are all private so we forbid accessing
    # projects not owned by current_user. We raise a RecordNotFound to avoid
    # possible leakages.
    if user != current_user
      raise ActiveRecord::RecordNotFound.new "Couldn't find User with identifier=#{ params[:id] }", User.name
    end

    @project = user.projects.find_by_name!(params[:project_name])
  end

  def get_finished
    user = User.find_by_identifier!(params[:id])

    # Note: for the moment, projects are all private so we forbid accessing
    # projects not owned by current_user. We raise a RecordNotFound to avoid
    # possible leakages.
    if user != current_user
      raise ActiveRecord::RecordNotFound.new "Couldn't find User with identifier=#{ params[:id] }", User.name
    end

    @projects = user.projects.finished
  end

  def start
    @project = current_project
    @project.start_now! due_at_param
  end

  def stop
    @project = current_project
    @project.stop_now!
  end

  def finish
    @project = current_project
    @project.finish_at! finished_at_param
  end

private

  def current_project
    @current_project ||= current_user.projects.find(params[:id])
  end

  def create_project_params
    fetch_resource_params(:project, [:name]).merge(user: current_user)
  end

  def update_project_params
    permitted_params = [:name, :description]
    permitted_params << :due_at if current_project.started?
    update_params = params.require(:project).permit(*permitted_params)
    update_params[:due_at] = update_params[:due_at].to_datetime if update_params.has_key? :due_at
    update_params
  end

  def due_at_param
    parameters = fetch_resource_params(:project, [:due_at])
    parameters[:due_at].to_datetime
  end

  def finished_at_param
    parameters = fetch_resource_params(:project, [:finished_at])
    parameters[:finished_at].to_datetime
  end

end
