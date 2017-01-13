class Api::ProjectsController < ApplicationController

  def create
    @project = Project.create!(create_project_params)
    render status: :created
  rescue ActionController::ParameterMissing, ActiveRecord::RecordInvalid => error
    render_error error.message
  end

  def update
    @project = current_user.projects.find(params[:id])
    @project.update! update_project_params
  rescue ActiveRecord::RecordNotFound
    render_error 'Project cannot be found', :not_found
  rescue ActionController::ParameterMissing, ActiveRecord::RecordInvalid => error
    render_error error.message
  end

private

  def create_project_params
    params.require(:project).permit(:name).tap do |project_params|
      project_params.require(:name)
    end.merge(user: current_user)
  end

  def update_project_params
    params.require(:project).permit(:name, :description)
  end

end
