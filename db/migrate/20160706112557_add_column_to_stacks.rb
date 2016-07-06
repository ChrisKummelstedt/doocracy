class AddColumnToStacks < ActiveRecord::Migration
  def change
    add_column :stacks, :project_id, :integer
    add_column :stacks, :inventory_id, :integer
  end
end
