class CreateReceipts < ActiveRecord::Migration
  def change
    create_table :receipts do |t|
      t.string :name
      t.date :date
      t.integer :amount
      t.boolean :booked
      t.datetime :bookeddate
      t.boolean :approved
      t.integer :approvedby
      t.datetime :approveddate
      t.boolean :paid
      t.integer :paidby
      t.date :paiddate
      t.timestamps null: false
    end
  end
end
