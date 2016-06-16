require 'rails_helper'

feature 'editing user profiles' do
  background do
    sign_up("Arnie")
  end

  scenario 'a user can change their own profile details' do
    click_link 'Arnie'
    click_link 'Edit Profile'
    attach_file('user_avatar', 'spec/files/images/avatar.jpg')
    fill_in 'user_bio', with: 'Is this real life?'
    click_button 'Update Profile'

    expect(page.current_path).to eq(profile_path('Arnie'))
    expect(page).to have_css("img[src*='avatar']")
    expect(page).to have_content('Is this real life?')
  end

  scenario "a user cannot see an Edit Profile button on another users profile" do
    click_link 'Logout'
    sign_up
    visit('/arnie')
    expect(page).to_not have_content('Edit Profile')
  end

  scenario "a user cannot navigate directly to edit a users profile" do
    visit '/bigrigoz/edit'

    expect(page).to_not have_content('Change your profile image:')
    expect(page.current_path).to eq(root_path)
    expect(page).to have_content("That profile doesn't belong to you!")
  end
end
