require 'spec_helper'

feature "Sign in with Facebook" do
  before do
    Rails.application.env_config["devise.mapping"] = Devise.mappings[:user]
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook]
  end
  #
  # it "sets a session variable to the OmniAuth auth hash" do
  #   Rails.application.env_config["omniauth.auth"][:uid].should == '1234'
  #   Rails.application.env_config["omniauth.auth"][:info][:email].should == 'johndoe@email.com'
  # end

  it "signs up with facebook" do
    # set_omniauth()
    visit '/'
    find_link("Sign in with Facebook").click
    find_link("Sign in with Facebook").click
    # visit "/"
    # click_link_or_button "Sign in with Facebook"
    expect(current_path).to eq('/')
    expect(page).to have_link"Logout"
  end
end
