class TeamsController < ApplicationController

  def new
    @project = Project.find(params[:project_id])
    @team = @project.teams.build
  end

  def show
    @team = Team.find(params[:id])
    @users = @team.users.all
  end

  def create
    @project = Project.find(params[:project_id])
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

  private

  def team_params
    params.require(:team).permit(:title, :description)
  end

end
