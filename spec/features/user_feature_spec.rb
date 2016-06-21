require 'spec_helper'

feature "Sign in with Facebook" do
  before do
    Rails.application.env_config["devise.mapping"] = Devise.mappings[:user]
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook]
  end

  it "signs up with facebook" do
    visit '/'
    click_link_or_button('Sign up')
    find_link("Sign in with Facebook").click
    expect(current_path).to eq('/')
    expect(page).to have_link"Logout"
  end
end
