feature "Add New Skill to User" do
  before do
    user = create :user
  end
  scenario "Create new Skill" do
        log_in
        create_skill
        expect(page).to have_content("Cooking Advanced BBQ")
  end
  scenario "Delete Skill" do
        log_in
        create_skill
        click_link "Delete skill"
        expect(page).not_to have_content("Cooking Advanced BBQ")
  end
  scenario "Can not see other skills" do
        log_in
        create_skill
        expect(page).to have_content("Cooking Advanced BBQ")
        click_link "Logout"
        sign_up
        visit '/skills'
        expect(page).not_to have_content("Cooking Advanced BBQ")
  end
end
