class AddControllerToProject < ActiveRecord::Migration
  def change
    add_column :projects, :controller, :string, :default => []
  end
end
