
feature "Add a project" do
  after do
    remove_uploaded_file
  end
  scenario "adding a project correctly" do
    sign_up
    click_link "Add a Project"
    expect(current_path).to eq(new_project_path)
    expect(page).to have_content("Let the journey begin")
    fill_in("Title", with: "awesome project title")
    fill_in("Description", with: "Looks like an awesome")
    fill_in("Total budget", with: 1000)
    attach_file('Image', "spec/files/images/project-puzzle.jpg")
    click_button "Create Project"
    expect(current_path).to eq(projects_path)
    expect(page).to have_content("Your project has been created.")
    expect(page).to have_content("awesome project title")
    expect(page).to have_content("Looks like an awesome")
    expect(page).to have_css("img[src*='project-puzzle.jpg']")
  end
end
