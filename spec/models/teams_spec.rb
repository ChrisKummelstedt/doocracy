describe Team, type: :model do

  describe "teams" do

    it "belong to project" do
      should belong_to :project
    end
  end
end
