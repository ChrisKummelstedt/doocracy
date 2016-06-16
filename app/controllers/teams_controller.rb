class TeamsController < ApplicationController
  before_action :set_project
  before_action :set_team, except: [:new, :create]
  # before_action :authenticate_user!, except: [:index]

  def new
    @team = @project.teams.build
  end

  def show
    @users = @team.users.all
    @budget = @team.budgets.new
    @budgets = @team.budgets.all
  end

  def create
    @team = @project.teams.build(team_params)
    current_user.teams << @team
    if @team.save
      flash[:notice] = 'Team created successfully'
      redirect_to project_path(@project)
    else
      flash[:notice] = 'Team not created'
      redirect_to request.referer
    end
  end

  def destroy
    @team.destroy
    flash[:notice] = "Team deleted successfully."
    redirect_to project_path(@project)
  end

  def edit
  end

  def update
    @team.update(team_params)
    redirect_to project_team_path(@project, @team)
  end


  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_team
    @team = Team.find(params[:id])
  end

  def team_params
    params.require(:team).permit(:title, :description)
  end

end
