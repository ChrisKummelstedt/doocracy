class CreateStacks < ActiveRecord::Migration
  def change
    create_table :stacks do |t|

      t.timestamps null: false
    end
  end
end
