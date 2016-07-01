class AddOwnerToItem < ActiveRecord::Migration
  def change
    add_column :items, :owner, :string, :default => []
  end
end
