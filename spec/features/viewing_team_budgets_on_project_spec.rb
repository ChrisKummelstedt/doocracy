feature "viewing pie chart of team budgets" do
  after do
    remove_uploaded_file
  end

  scenario "Can see the different team budgets" do
    create_project
    create_team
    click_link "Coding Team"
    create_team_budget
    click_link "awesome project title"
    expect(page).to have_content("awesome project title")
    expect(page).to have_content("Coding Team: 100.0%")
    expect(page).to have_content("1000")
    expect(page).to have_css("img[src*='project-puzzle.jpg']")
  end
end