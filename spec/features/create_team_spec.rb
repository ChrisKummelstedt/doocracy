feature "Create a Team" do
  after do
    remove_uploaded_file
  end
  scenario "Creating a team correctly" do
    sign_up
    create_project
    click_link 'awesome project title'
    click_link "Create a Team"
    fill_in("Title", with: "Coding Team")
    fill_in("Description", with: "Code Stuff")
    click_button "Create Team"
    expect(page).to have_content("Coding Team")
    expect(page).to have_content("Code Stuff")
  end
end
