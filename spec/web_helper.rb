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

<<<<<<< HEAD
def create_skill
	visit '/skills'
	expect(current_path).to have_content('/skills')
	fill_in("Skill", with: 'Cooking')
	select 'Advanced', from: 'Skilllevel'
	fill_in("Description", with: 'BBQ')
	click_button "Create Skill"
=======
def create_project_1
	sign_up
	click_link "Add a Project"
    fill_in("Title", with: "awesome project title")
    fill_in("Description", with: "Looks like an awesome")
    fill_in("Total budget", with: 1000)
    attach_file('Image', "spec/files/images/project-puzzle.jpg")
    click_button "Create Project"
>>>>>>> 38943ba14b1bab9133e7e51f316b0504076bf3de
end

def remove_uploaded_file
	FileUtils.rm_rf(Rails.root + "public/system")
end
