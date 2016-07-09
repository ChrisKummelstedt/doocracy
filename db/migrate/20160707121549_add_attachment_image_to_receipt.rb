class AddAttachmentImageToReceipt < ActiveRecord::Migration
  def self.up
    change_table :receipts do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :receipts, :image
  end
end
