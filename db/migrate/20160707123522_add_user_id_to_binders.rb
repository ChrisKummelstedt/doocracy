class AddUserIdToBinders < ActiveRecord::Migration
  def change
    add_column :binders, :user_id, :integer
  end
end
