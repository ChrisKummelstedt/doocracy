class BudgetsController < ApplicationController
  def index
    @budget_items = Budget.budget_item.all
  end

  def create
    Budget.create(budget_params)
    redirect_to root_path
  end
end
