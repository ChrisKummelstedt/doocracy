feature "sign-up" do
  context "valid credentials" do
    scenario "signs up successfully" do
      sign_up
      expect(page).not_to have_link "Login"
      expect(page).to have_link "Logout"
      expect(page).to have_content "myUsername"
      expect(page).to have_content "Welcome! You have signed up successfully."
    end
  end

  context "invalid credentials" do
    scenario "sign-up with too short a user name" do
      sign_up("pee")
      expect(page).not_to have_link "Logout"
      expect(page).to have_link "Login"
      expect(page).to have_content "is too short (minimum is 4 characters)"
    end

    scenario "sign-up with long a user name" do
      sign_up("peeeeeeeeeeeeweeeeeeeeeeeeeeeeeeeeeeeeeeeee")
      expect(page).not_to have_link "Logout"
      expect(page).to have_link "Login"
      expect(page).to have_content "is too long (maximum is 16 characters)"
    end

    scenario "sign-up without supplying a user name" do
      sign_up(nil)
      expect(page).not_to have_link "Logout"
      expect(page).to have_link "Login"
      expect(page).to have_content "can't be blank"
    end

    scenario "sign-up with a user name that already exists" do
      sign_up
      click_link "Logout"
      sign_up
      expect(page).not_to have_link "Logout"
      expect(page).to have_link "Login"
      expect(page).to have_content "has already been taken"
    end
  end
end
