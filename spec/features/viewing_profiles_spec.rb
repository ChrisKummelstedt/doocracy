require 'rails_helper'

feature "Visit a Profile" do
  after do
    remove_uploaded_file
  end
  scenario 'visiting a profile page shows the user name in the url' do
    sign_up
    click_link("myUsername")
    expect(page.current_path).to eq(profile_path('myUsername'))
  end

end
