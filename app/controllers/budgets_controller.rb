class BudgetsController < ApplicationController

  def index
    # @team = Team.find(params[:team_id])
    @budgets = Budget.all
  end

  def new
    @team = Team.find(params[:id])
    @budget = @team.budgets.build
  end

  def create
    @team = Team.find(params[:team_id])
    @budget = @team.budgets.build(budget_params)
    # Budget.create(budget_params)
    respond_to do |format|
      format.html { redirect_to project_team_budgets_path }
      format.js { }
    end
  end

  def destroy
    @budget = Budget.find(params[:id])
    @budget.destroy
    respond_to do |format|
    format.html { redirect_to project_team_budgets_path }
    format.js { }
    end
  end

  private

  def budget_params
    params.require(:budget).permit(:title, :budget_item, :quantity, :cost_per_item)
  end
end
