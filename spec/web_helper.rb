require 'fileutils'

def log_in(user = {email: "amy@gmail.com", password: "testtest"})
	visit("/")
	click_link("Login")
	fill_in("Email", with: user[:email])
	fill_in("Password", with: user[:password])
	click_button("Login")
end

def sign_up(username = "myUsername")
	visit("/")
	click_link("Sign up")
	fill_in("User name", with: username)
	fill_in("Email", with: "test@example.com")
	fill_in("Password", with: "testtest")
	fill_in("Password confirmation", with: "testtest")
	click_button("Sign up")
end

def remove_uploaded_file
	FileUtils.rm_rf(Rails.root + "public/system")
end
