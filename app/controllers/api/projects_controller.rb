class Api::ProjectsController < ApiController

  def show
    @project = current_project
  end

  def update
    @project = current_project
    @project.update! update_project_params

    NotificationsChannel.broadcast_to(
      current_user,
      action: 'update#projects',
      id: @project.id,
      updatedAt: @project.updated_at.to_i,
    )
  end

  def destroy
    current_project.destroy!
  end

  def update_state
    @project = current_project
    @project.update_with_transition! update_project_state_params

    NotificationsChannel.broadcast_to(
      current_user,
      action: 'update#projects',
      id: @project.id,
      updatedAt: @project.updated_at.to_i,
    )
  end

private

  def current_project
    @current_project ||= current_user.projects.find(params[:id])
  end

  def update_project_params
    permitted_params = %i[name description]
    permitted_params << :due_at if current_project.started?
    params.require(:project).permit(*permitted_params)
  end

  def update_project_state_params
    state = params[:project][:state]
    if state == 'started'
      fetch_resource_params(:project, %i[state due_at])
    elsif state == 'finished'
      fetch_resource_params(:project, %i[state finished_at])
    else
      fetch_resource_params(:project, %i[state])
    end
  end
end
