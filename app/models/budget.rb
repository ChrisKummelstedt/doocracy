class Budget < ActiveRecord::Base
  belongs_to :team, :foreign_key => "teamID"
end
