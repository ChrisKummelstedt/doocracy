class AddBinderRefToReceipts < ActiveRecord::Migration
  def change
    add_reference :receipts, :binder, index: true, foreign_key: true
  end
end
