class AddTeamIdToBudgets < ActiveRecord::Migration
  def change
    add_reference :budgets, :team, index: true, foreign_key: true
  end
end
