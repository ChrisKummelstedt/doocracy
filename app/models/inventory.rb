class Inventory < ActiveRecord::Base
  validates :name, :description, presence: true

  has_many :items, :dependent => :destroy
  belongs_to :user

end
