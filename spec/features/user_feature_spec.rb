require 'spec_helper'

describe User, "OmniAuth" do
  before do
    Rails.application.env_config["devise.mapping"] = Devise.mappings[:user]
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook]
  end

  it "sets a session variable to the OmniAuth auth hash" do
    Rails.application.env_config["omniauth.auth"][:uid].should == '1234'
  end
end
