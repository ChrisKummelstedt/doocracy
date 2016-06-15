
feature "Budget item" do
  after do
    remove_uploaded_file
  end
  scenario "adding a budget item" do
    create_project
    create_team
    click_link "Coding Team"
    expect(current_path).to eq('/projects/1/teams/1')

  end
end
