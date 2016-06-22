class CreateItemtags < ActiveRecord::Migration
  def change
    create_table :itemtags do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
