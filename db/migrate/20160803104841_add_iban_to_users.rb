class AddIbanToUsers < ActiveRecord::Migration
  def change
    add_column :users, :iban, :string
    add_column :users, :swift, :string
    add_column :users, :swish, :string
    add_column :users, :choice, :string
  end
end
