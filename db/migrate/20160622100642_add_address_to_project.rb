class AddAddressToProject < ActiveRecord::Migration
  def change
    add_column :projects, :address, :string
  end
end
