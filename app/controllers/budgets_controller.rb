class BudgetsController < ApplicationController
  before_action :set_project

  def index
    @budgets = Budget.all
  end

  def create
    @team = Team.find(params[:team_id])
    @budget = @team.budgets.create(budget_params)
    respond_to do |format|
      format.html { redirect_to project_team_path(@project, @team) }
      format.js { }
    end
  end

  def destroy
    @team = Team.find(params[:team_id])
    @budget = @team.budgets.find(params[:id])
    @budget.destroy
    respond_to do |format|
      format.html { redirect_to project_team_path(@project, @team) }
      format.js { }
    end
  end

  private
  def set_project
    @project = Project.find(params[:project_id])
  end

  def budget_params
    params.require(:budget).permit(:title, :budget_item, :quantity, :cost_per_item)
  end
end
