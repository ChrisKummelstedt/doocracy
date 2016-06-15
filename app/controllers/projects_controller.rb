class ProjectsController < ApplicationController

  def index
    @projects = Project.all
  end

  def show
    @project = Project.find(params[:id])
  end

  def new
    @project = current_user.projects.build
  end

  def create
    @project = current_user.projects.build(project_params)
    @project.save
    flash[:notice] = "Your project has been created."
    redirect_to projects_path
  end


  private

  def project_params
    params.require(:project).permit(:title, :description, :budget, :image)
  end


end
