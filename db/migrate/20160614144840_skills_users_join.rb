class SkillsUsersJoin < ActiveRecord::Migration
  def self.up
    create_table 'skills_users', :id => false do |t|
      t.column 'skill_id', :integer
      t.column 'user_id', :integer
    end
  end
end
