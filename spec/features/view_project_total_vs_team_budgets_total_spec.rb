feature "viewing graph of team budgets vs project budget" do
  after do
    remove_uploaded_file
  end

  scenario "Can see a graph of team budgets vs project budget" do
    create_project
    create_team
    first('.table').click_link "Coding Team"
    create_team_budget
    click_link "awesome project title"
    expect(page).to have_content("awesome project title")
    expect(page).to have_content("1000")
    page.html.should include("{series.name}: {point.y}<br/>Total: {point.stackTotal}")
    expect(page).to have_css("img[src*='project-puzzle.jpg']")
  end
end
