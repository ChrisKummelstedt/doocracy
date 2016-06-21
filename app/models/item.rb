class Item < ActiveRecord::Base
  validates :title, :description, :inventory_id, presence: true  
  belongs_to :inventory

  has_attached_file :image, styles: { large: "500x500>", medium: "300x300>", thumb: "100x100>" }
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

end
