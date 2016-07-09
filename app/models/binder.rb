class Binder < ActiveRecord::Base
  has_many :receipts, :dependent => :destroy
  belongs_to :user
end
