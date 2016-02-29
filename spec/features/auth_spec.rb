require 'rails_helper'
require 'capybara/rails'

feature 'Auth' do
  scenario 'Users can login and out' do
    create_user email: "user@example.com"

    visit root_path
    within(".signin-form") { click_on "Login" }
    expect(page).to have_content("Username / password is invalid")

    fill_in "Email", with: "user@example.com"
    fill_in "Password", with: "password"
    within(".signin-form") { click_on "Login" }
    expect(page).to have_content("user@example.com")
  end

  scenario 'Once a user is created they should be logged in' do
    create_user email: "user@example.com"

    visit root_path
    within(".auth") { click_on "Register" }
    expect(page).to have_content("Register")

    fill_in "Email", with: "user@example.com"
    fill_in "Password", with: "password"
    fill_in "Confirm", with: "password"

    within('.registration-form') { click_on "Register"}
    expect(current_path).to eql(registrations_path)
  end
end
