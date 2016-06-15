describe Project, type: :model do

  describe "projects" do

    it "belong to user" do
      should belong_to :user
    end

    it "has correct association with teams" do
      should have_many :teams
    end
  end
end
