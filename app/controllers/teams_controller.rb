class TeamsController < ApplicationController

  def new
    @project = Project.find(params[:project_id])
    @team = @project.teams.build
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

  def show
    @project = Project.find(params[:project_id])
    @team = Team.find(params[:id])
  end

  def edit
    @project = Project.find(params[:project_id])
    @team = Team.find(params[:id])
  end

  def update
    @project = Project.find(params[:project_id])
    @team = Team.find(params[:id])
    @team.update(team_params)
    redirect_to project_team_path(@project, @team)
  end


  private

  def team_params
    params.require(:team).permit(:title, :description)
  end

end
