class Api::ProjectsController < ApiController

  def show
    @project = current_project
  end

  def update
    @project = current_project
    @project.update! update_project_params
  end

  def update_state
    @project = current_project
    @project.update_with_transition! update_project_state_params
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

  def update_project_state_params
    state = params[:project][:state]
    parameters = if state == 'started'
                   fetch_resource_params(:project, [:state, :due_at])
                 elsif state == 'finished'
                   fetch_resource_params(:project, [:state, :finished_at])
                 else
                   fetch_resource_params(:project, [:state])
                 end
    parameters[:due_at] = parameters[:due_at].to_datetime if parameters.has_key? :due_at
    parameters[:finished_at] = parameters[:finished_at].to_datetime if parameters.has_key? :finished_at
    parameters
  end

end
