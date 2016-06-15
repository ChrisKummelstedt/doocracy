class BudgetsController < ApplicationController

  def index
    @budgets = Budget.all
  end

  def create
    @budget = Budget.create(budget_params)
    respond_to do |format|
      format.html { redirect_to budgets_path }
      format.js { }
    end
  end

  def destroy
    @budget = Budget.find(params[:id])
    @budget.destroy
    respond_to do |format|
    format.html { redirect_to budgets_path }
    format.js { }
    end
  end

  private

  def budget_params
    params.require(:budget).permit(:title, :budget_item, :quantity, :cost_per_item)
  end
end
