class AddItemBorrowFields < ActiveRecord::Migration
  def up
    add_column :items, :borrowed_by, :string, :default => []
    add_column :items, :borrow_secret_key, :string
    add_column :items, :borrow_status, :string
  end

  def down
    remove_column :items, :borrowed_by
    remove_column :items, :borrow_secret_key
    remove_column :items, :borrow_status
  end
end
