describe Project, type: :model do

  describe "projects" do

    it "belong to users" do
      should belong_to :user
    end
  end
end