class AddTeamToReceipts < ActiveRecord::Migration
  def change
    add_reference :receipts, :team, index: true, foreign_key: true
  end
end
