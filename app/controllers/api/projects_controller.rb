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
    unless @project.started?
      @project.start_now! due_at_param
    else
      render_error 'Project has already been started'
    end
  end

  def stop
    @project = current_project
    if @project.stopped?
      render_error 'Project has already been stopped'
    elsif @project.finished?
      render_error 'Project has already been finished'
    else
      @project.stop_now!
    end
  end

  def finish
    @project = current_project
    unless @project.finished?
      @project.finish_at! finished_at_param
    else
      render_error 'Project has already been finished'
    end
  end

private

  def current_project
    @current_project ||= current_user.projects.find(params[:id])
  end

  def create_project_params
    params.require(:project).permit(:name).tap do |project_params|
      project_params.require(:name)
    end.merge(user: current_user)
  end

  def update_project_params
    update_params = params.require(:project).permit(:name, :description)
    update_params[:due_at] = Time.at(params[:project][:due_at].to_i).utc.to_datetime if current_project.started?
    update_params
  end

  def due_at_param
    due_at_timestamp = params.require(:project).permit(:due_at).tap do |project_params|
      project_params.require(:due_at)
    end[:due_at].to_i
    Time.at(due_at_timestamp).utc.to_datetime
  end

  def finished_at_param
    timestamp = params.require(:project).permit(:finished_at).tap do |project_params|
      project_params.require(:finished_at)
    end[:finished_at].to_i
    Time.at(timestamp).utc.to_datetime
  end

end
