feature "Search for projects" do
  after do
    remove_uploaded_file
  end

  scenario "Searching for a project based on title" do
    create_project
    click_link("Logout")
    create_project_2
    click_link("Do/ocracy")
    fill_in("search", with: "new")
    click_button("Search")
    expect(page).to have_content("new project title")
    expect(page).not_to have_content("awesome project title")
  end
end