
feature "Add a project" do
  after do
    remove_uploaded_file
  end

  scenario "adding a project correctly" do
    create_project
    expect(page).to have_content("Your project has been created.")
    expect(page).to have_content("awesome project title")
    expect(page).to have_content("Looks like an awesome")
    expect(page).to have_content("1000")
  end
  scenario "adding a project correctly" do
    stub_request(:get, "http://maps.googleapis.com/maps/api/geocode/json?address=oxford%20street,%20london,%20england&language=en&sensor=false").
            with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).
            to_return(:status => 200, :headers => {})
  	sign_up
  	click_link "create-a-new-project"
  	click_button "Create Project"
    expect(page).to have_content("Your project has not been created, you left something blank.")
  end
end
