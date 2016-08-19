class AddInUseToItem < ActiveRecord::Migration
  def change
    add_column :items, :in_use, :string, :default => []
  end
end
