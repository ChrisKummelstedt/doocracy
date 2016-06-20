feature "Join a Team" do
  before do
    user = create :user
  end
  after do
    remove_uploaded_file
  end
  scenario "Join a team correctly" do
    create_project
    create_team
    first('.table').click_link("Coding Team")
    click_button('Join Team')
    expect(page).to have_content("Successfully Join Team")
  end
end
