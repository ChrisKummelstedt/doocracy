feature "Delete a Team" do
  after do
    remove_uploaded_file
  end
  scenario "Deleting a team correctly" do
    create_project
    create_team
    first('.table').click_link("Coding Team")
    click_link("Edit")
    click_button("Delete")
    expect(page).not_to have_content("Coding Team")
    expect(page).not_to have_content("Code Stuff")
  end
end
