class Team < ActiveRecord::Base
  has_and_belongs_to_many :users
  belongs_to :project
  has_many :budgets, :foreign_key => "team_id", dependent: :destroy

  validates :project_id, :title, :description, presence: true
  
end
