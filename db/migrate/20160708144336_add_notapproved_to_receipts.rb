class AddNotapprovedToReceipts < ActiveRecord::Migration
  def change
    add_column :receipts, :notapproved, :string 
  end
end
