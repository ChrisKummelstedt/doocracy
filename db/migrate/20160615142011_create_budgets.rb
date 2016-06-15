class CreateBudgets < ActiveRecord::Migration
  def change
    create_table :budgets do |t|
      t.string :budget_item
      t.integer :quantity
      t.float :cost_per_item

      t.timestamps null: false
    end
  end
end
