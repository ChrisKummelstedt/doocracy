class Budget < ActiveRecord::Base
  validates :budget_item, :quantity, :cost_per_item, presence: true
  belongs_to :team, :foreign_key => "team_id"

  def sum(budgets)
    sum = 0
    budgets.each do |budget|
      sum += budget.quantity * budget.cost_per_item
    end
    return sum
  end
end
