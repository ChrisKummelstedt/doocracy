class AddUmbrellaToReceipts < ActiveRecord::Migration
  def change
    add_column :receipts, :umbrella, :integer
  end
end
