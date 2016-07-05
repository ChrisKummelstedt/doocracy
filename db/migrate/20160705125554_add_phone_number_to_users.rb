class AddPhoneNumberToUsers < ActiveRecord::Migration
  def change
    add_column :users, :phone_number, :string
    add_column :users, :skype, :string
    add_column :users, :city, :string
    add_column :users, :country, :string
  end
end
