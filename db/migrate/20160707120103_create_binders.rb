class CreateBinders < ActiveRecord::Migration
  def change
    create_table :binders do |t|
      t.string :name
      t.timestamps null: false
    end
  end
end
