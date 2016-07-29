class AddFocusToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :focus, :string
  end
end
