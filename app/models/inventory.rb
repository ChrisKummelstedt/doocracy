class Inventory < ActiveRecord::Base
  validates :name, :description, presence: true

  has_many :items, :dependent => :destroy

end
