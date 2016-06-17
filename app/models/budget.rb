class Budget < ActiveRecord::Base
  belongs_to :team, :foreign_key => "team_id"

  def sum(budgets)
    sum = 0
    budgets.each do |budget|
      sum += budget.quantity * budget.cost_per_item
    end
    return sum
  end
end
