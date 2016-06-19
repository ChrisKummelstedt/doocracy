class AddTeamBudgetToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :team_budget, :float
  end
end
