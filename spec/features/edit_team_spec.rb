feature "Edit a Team" do
  after do
    remove_uploaded_file
  end
  scenario "Editing a team correctly" do
    create_project
    create_team
    first('.table').click_link("Coding Team")
    click_button("Edit Team")
    fill_in("team_title", with: "Coding Team2")
    fill_in("team_description", with: "Code Stuff2")
    click_button("Update Team")
    expect(page).to have_content("Coding Team2")
    expect(page).to have_content("Code Stuff2")
  end

  scenario "Can't edit a team if your not part of the team" do
    create_project
    create_team
    click_link("Logout")
    visit("/")
    click_link("awesome project title")
    first('.table').click_link("Coding Team")
    expect(page).to have_content("You need to sign in or sign up before continuing.")
  end
end
