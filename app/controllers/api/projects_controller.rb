class Api::ProjectsController < ApplicationController

  def create
    @project = Project.create!(create_project_params)
    render status: :created
  rescue ActionController::ParameterMissing, ActiveRecord::RecordInvalid => error
    render_error error.message
  end

private

  def create_project_params
    params.require(:project).permit(:name).tap do |project_params|
      project_params.require(:name)
    end.merge(user: current_user)
  end

end
