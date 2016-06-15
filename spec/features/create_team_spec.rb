feature "Create a Team" do
  after do
    remove_uploaded_file
  end
  scenario "Creating a team correctly" do
    create_project
    create_team
    expect(page).to have_content("Coding Team")
    expect(page).to have_content("Code Stuff")
  end
end
