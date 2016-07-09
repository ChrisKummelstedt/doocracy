class AddUserToReceipts < ActiveRecord::Migration
  def change
    add_reference :receipts, :user, index: true, foreign_key: true
  end
end
