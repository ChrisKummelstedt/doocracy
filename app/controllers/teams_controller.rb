class TeamsController < ApplicationController
  before_action :set_project
  before_action :set_team, except: [:new, :create, :leave_team]
  before_action :authenticate_user!, only: [:show]

  def new
    @team = @project.teams.build
  end

  def create
    if current_user
      @team = @project.teams.build(team_params)
      if @team.save
        current_user.teams << @team
        flash[:notice] = 'Team created successfully'
        redirect_to project_path(@project)
      else
        flash[:notice] = 'Team not created, it needs a title and a description first'
        render :action=>'new'
      end
    end
  end

  def show
    @users = @team.users.all
    @budget = @team.budgets.new
    @budgets = @team.budgets.all
    @todo = @team.todos.new
    @todos = @team.todos.where(:completed => false)
    @completedtodos = @team.todos.where(:completed => true)
    @receipts = @team.receipts.all
    @receiptstotal = receiptstotal
  end

  def join_team
    if check_membership
      flash[:alert] = "Already on team"
    else
      @team.users << current_user
      flash[:notice] = "Successfully Join Team"
    end
    redirect_to project_team_path(@project, @team)
  end

  def leave_team
    @team = Team.find(params[:team_id])
    current_user.teams.delete(@team)
    flash[:notice] = "Successfully Left Team"
    redirect_to project_team_path(@project, @team)
  end

  def destroy
    @team.destroy
    flash[:notice] = "Team deleted successfully."
    redirect_to project_path(@project)
  end

  def edit

  end

  def update
    if Team.includes(:users).where(users: { id: current_user.id } ).any?
      @team.update(team_params)
      redirect_to project_team_path(@project, @team)
    end
  end


  private

  def receiptstotal
    @receipts = @team.receipts.all
    @receiptstotal = 0
    @receipts.each do |receipt|
      @receiptstotal += receipt.amount
    end
    @receiptstotal
  end

  def check_membership
    Team.find(params[:id]).users.include?(current_user)
  end

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
