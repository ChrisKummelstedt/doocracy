require 'fileutils'

def log_in(user = {email: "amy@gmail.com", password: "testtest"})
	visit("/")
	click_link("Login")
	fill_in("Email", with: user[:email])
	fill_in("Password", with: user[:password])
	click_button("Log in")
end

def sign_up(username = "myUsername", email = "test@example.com")
	visit("/")
	click_link("Sign up")
	fill_in("user_user_name", with: username)
	fill_in("user_email", with: email)
	fill_in("user_password", with: "testtest")
	fill_in("user_password_confirmation", with: "testtest")
	click_button("Sign up")
end

def sign_up_with_Arnie(username = "Arnie")
	visit("/")
	click_link("Sign up")
	fill_in("user_user_name", with: username)
	fill_in("user_email", with: "test@example.com")
	fill_in("user_password", with: "testtest")
	fill_in("user_password_confirmation", with: "testtest")
	click_button("Sign up")
end

def create_skill
	sign_up("asdf")
	click_link "asdf"
	page.find("#edit-profile").click
	fill_in("Skill", with: 'Cooking')
	select 'Advanced', from: 'Skilllevel'
	fill_in("Description", with: 'BBQ')
	click_button "Create Skill"
	click_button "Update Profile"
end

def create_project
	sign_up
	click_link "Add a Project"
	fill_in("project_title", with: "awesome project title")
	fill_in("project_description", with: "Looks like an awesome")
	fill_in("project_total_budget", with: 1000)
	attach_file('Image', "spec/files/images/project-puzzle.jpg")
	click_button "Create Project"
end

def create_team
	click_link "Create a Team"
	fill_in("Title", with: "Coding Team")
	fill_in("Description", with: "Code Stuff")
	click_button "Create Team"
end

def remove_uploaded_file
	FileUtils.rm_rf(Rails.root + "public/system")
end
