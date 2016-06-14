feature "Edit a project" do
  after do
    remove_uploaded_file
  end
  scenario "editing a project correctly" do
    create_project_1
    click_link "My Projects"
    click_button "Edit"
    expect(current_path).to eq(edit_project_path)
    fill_in("Title", with: "awesome project title edited")
    fill_in("Description", with: "Looks like an awesome edited")
    fill_in("Total budget", with: 1000)
    attach_file('Image', "spec/files/images/project-puzzle.jpg")
    click_button "submit"
    expect(current_path).to eq(projects_path)
    expect(page).to have_content("awesome project title edited")
    expect(page).to have_content("Looks like an awesome edited")
    expect(page).to have_css("img[src*='project-puzzle.jpg']")
  end
end