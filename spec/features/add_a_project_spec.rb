
feature "Add a project" do
  after do
    remove_uploaded_file
  end
  scenario "adding a project correctly" do
    create_project
  end
end
