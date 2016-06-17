class BudgetsController < ApplicationController
  before_action :set_project, :set_team, :set_budgets

  def index
  end

  def create
    @budget = @team.budgets.create(budget_params)
    @team = Team.where(params[:id]).first_or_initialize
    @team.team_budget = @budgets.first.sum(@budgets).to_f
    @team.save
    respond_to do |format|
      format.html { redirect_to project_team_path(@project, @team) }
      format.js { }
    end
  end

  def destroy
    @budget = @team.budgets.find(params[:id])
    @budget.destroy
    @team.team_budget = @budgets.first.sum(@budgets).to_f
    @team.save
    respond_to do |format|
      format.html { redirect_to project_team_path(@project, @team) }
      format.js { }
    end
  end

  private

  def set_budgets
    @budgets = @team.budgets.all
  end

  def set_team
    @team = Team.find(params[:team_id])
  end

  def set_project
    @project = Project.find(params[:project_id])
  end

  def budget_params
    params.require(:budget).permit(:title, :budget_item, :quantity, :cost_per_item)
  end
end
