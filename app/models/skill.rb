class Skill < ActiveRecord::Base
  validates :skill, :skilllevel, :description, presence: true
  has_and_belongs_to_many :users
end
