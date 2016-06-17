class ProjectsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

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

  def update
    @project = Project.find(params[:id])
    @project.update(project_params)
    redirect_to project_path(@project)
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    flash[:notice] = "Project deleted successfully."
    redirect_to root_path
  end

  def new
    @project = current_user.projects.build
  end

  def create
    @project = current_user.projects.build(project_params)
    @project.save
    flash[:notice] = "Your project has been created."
    redirect_to project_path(@project)
  end

  def user_projects_path
    @projects = current_user.projects(project_params)
  end

  private

  def project_params
    params.require(:project).permit(:title, :description, :total_budget, :image)
  end


end
