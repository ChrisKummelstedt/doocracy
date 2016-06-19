feature "Edit a project" do
  after do
    remove_uploaded_file
  end
  scenario "editing a project correctly" do
    create_project
    click_link "my-projects"
    click_link "edit"
    fill_in("project_title", with: "awesome project title edited")
    fill_in("project_description", with: "Looks like an awesome edited")
    fill_in("project_total_budget", with: 1000)
    attach_file('Image', "spec/files/images/project-puzzle.jpg")
    click_button "Update Project"
    expect(page).to have_content("awesome project title edited")
    expect(page).to have_content("Looks like an awesome edited")
    expect(page).to have_css("img[src*='project-puzzle.jpg']")
  end
end
