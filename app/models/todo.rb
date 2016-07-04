class Todo < ActiveRecord::Base
  validates :description, presence: true
  belongs_to :team, :foreign_key => "team_id"
  belongs_to :user  
end
