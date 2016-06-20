class AddInventoryRefToItems < ActiveRecord::Migration
  def change
    add_reference :items, :inventory, index: true, foreign_key: true
  end
end
