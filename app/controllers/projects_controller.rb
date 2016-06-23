class ProjectsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]


  def index
    @projects = Project.all
    if params[:search]
      @projects = Project.search(params[:search]).order("created_at DESC")
    else
      @projects = Project.all.order('created_at DESC')
    end
  end

  def show
    @project = Project.find(params[:id])
    @usercount = user_count
  end

  def mine
    @my_projects = current_user.projects
    @my_teams = current_user.teams
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
    if @project.save
      flash[:notice] = "Your project has been created."
      redirect_to project_path(@project)
    else
      flash[:notice] = "Your project has not been created, you left something blank."
      redirect_to request.referer
    end
  end

  def user_projects_path
    @projects = current_user.projects(project_params)
  end

  def about
  end

  private

  def user_count
    usercount = []
    @project.teams.each do |team|
      team.users.each do |team_member|
        usercount << team_member.user_name
      end
    end
    usercount.uniq.size
  end

  def project_params
    params.require(:project).permit(:title, :description, :total_budget, :image, :address, :search)
  end


end
