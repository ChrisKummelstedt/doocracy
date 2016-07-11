class AddSizeToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :size, :integer
  end
end
