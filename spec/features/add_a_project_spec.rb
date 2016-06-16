
feature "Add a project" do
  after do
    remove_uploaded_file
  end
  
  scenario "adding a project correctly" do
    create_project
    expect(current_path).to eq(projects_path)
    expect(page).to have_content("Your project has been created.")
    expect(page).to have_content("awesome project title")
    expect(page).to have_content("Looks like an awesome")
    expect(page).to have_css("img[src*='project-puzzle.jpg']")
  end
end
