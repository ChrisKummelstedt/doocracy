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

  scenario "Creating a team incorrectly" do
   create_project
   click_link "Create a Team"
   click_button "Create Team"
   expect(page).to have_content("Team not created")
 end
 
end
