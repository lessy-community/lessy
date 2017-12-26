class Api::Users::ProjectsController < ApiController

  def index
    @projects = current_user.projects.page(params[:page])
  end

  def create
    @project = Project.create!(create_project_params)
    render status: :created
  end

private

  def create_project_params
    parameters = fetch_resource_params(:project, [:name]).merge(user: current_user)
    parameters[:slug] = parameters[:name]
    parameters
  end

end
