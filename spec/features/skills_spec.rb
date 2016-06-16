feature "Add New Skill to User" do
  before do
    user = create :user
  end
  scenario "Create new Skill" do
        create_skill
        expect(page).to have_content("Cooking Advanced BBQ")
  end
  scenario "Delete Skill" do
        create_skill
        page.find("#edit-profile").click
        click_link "Delete skill"
        click_button "Update Profile"
        expect(page).not_to have_content("Cooking Advanced BBQ")
  end
  scenario "Can see other skills" do
        create_skill
        click_link "Logout"
        sign_up("test", "asdf@asdf.com")
        visit '/asdf/'
        expect(page).to have_content("Cooking Advanced BBQ")
  end
end
