
feature "Delete a project" do
  after do
    remove_uploaded_file
  end

  scenario "removing a project correctly" do
    create_project
    click_link "My Projects"
    click_link "Edit"
    click_button "Delete"
    expect(page).should_not have_content("awesome project title")
    expect(page).to have_content 'Project deleted successfully'
  end

  # scenario "cant remove a project unless you are owner" do
  #   create_project_1
  #   click_link "Logout"
  #   sign_up(username :"myUsername2", email:"c@g.com")
  #   visit "/projects/2/edit"
  #   click_button "Delete"
  #   expect(page).to have_content("awesome project title")
  #   expect(page).to have_content("You can't delete other peoples projects!")
  # end

end
