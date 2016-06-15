class ProjectsController < ApplicationController

  def index
    @projects = Project.all
  end

  def show
    @project = Project.find(params[:id])
  end

  def mine
    @my_projects = current_user.projects
  end

  def edit
    @project = Project.find(params[:id])
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    flash[:notice] = "Project deleted successfully."
    redirect_to projects_path
  end

  def update
    @my_project = Project.find(params[:id])
    @my_project.update(project_params)
    redirect_to projects_path
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

  def user_projects_path
    @projects = current_user.projects(project_params)
  end

  private

  def project_params
    params.require(:project).permit(:title, :description, :budget, :image)
  end


end
