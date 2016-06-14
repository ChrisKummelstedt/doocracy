class CreateSkilllists < ActiveRecord::Migration
  def change
    create_table :skilllists do |t|
      t.string :skill
      t.string :skilllevel
      t.string :description
      t.timestamps null: false
    end
  end
end
