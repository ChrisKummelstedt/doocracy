describe User, type: :model do

  describe "users" do

    it "has correct association with project" do
      should have_many :projects
    end
  end
end
