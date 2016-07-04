class AddTeamIdToTodos < ActiveRecord::Migration
  def change
    add_reference :todos, :team, index: true, foreign_key: true
  end
end
