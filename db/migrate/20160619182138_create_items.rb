class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :title
      t.text :description
      t.text :tags, array: true, default: []
      t.timestamps null: false
    end
  end
end
