class Stack < ActiveRecord::Base
  belongs_to :project
  belongs_to :inventory
end
