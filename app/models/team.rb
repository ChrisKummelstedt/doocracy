class Team < ActiveRecord::Base
  validates :project_id, :title, :description, presence: true
  belongs_to :project
  has_and_belongs_to_many :users
end