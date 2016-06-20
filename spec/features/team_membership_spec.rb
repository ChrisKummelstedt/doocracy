feature "Team Membership" do
  before do
    user = create :user
  end
  after do
    remove_uploaded_file
  end
  scenario "Join a team correctly" do
    create_project
    create_team
    first('.table').click_link("Coding Team")
    expect(page).to have_content("myUsername")
  end

  scenario "leave a team correctly" do
    create_project
    create_team
    first('.table').click_link("Coding Team")
    click_button "Leave Team"
    expect(page).not_to have_content("myUsername")
  end
end
