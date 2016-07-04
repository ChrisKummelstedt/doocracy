class AddCompletedToTodos < ActiveRecord::Migration
  def change
    add_column :todos, :completed, :boolean, :null => false, :default => false
  end
end
