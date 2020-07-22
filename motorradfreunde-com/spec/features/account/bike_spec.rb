require 'rails_helper'

feature "Account bikes" do

  # given(:logged_in_user) do
  #   p "logged_in_user"
  #   name = "Homer Simpson"
  #   unless user = User.find_by_name(name)
  #     user = FactoryGirl.create(:user, :name => name)
  #   end
  #   current_user = user

  #   visit('/users/login')
  #   fill_in("eMail",    :with => current_user.email)
  #   fill_in("Passwort", :with => "secret")
  #   click_button("Anmelden")
  #   current_user
  # end


  # background do
  #   # Given a logged in user called "Homer Simpson"
  #   # And   I am on my account page
  #   logged_in_user
  # end

  # before do
  #   p "--------------------------"
  # end

  # before do
  #   # visit("/")
  #   # click_link("Login")
  #   # fill_in("user_email", :with => "blah@wp.pl")
  #   # fill_in("user_password", :with => "itsnotreal")
  #   # click_button("Sign in")
  # end

  # # scenario "should allow to change first name and surname" do
  # #   find("#user-nav a.account").click
  # #   fill_in("user_first_name", :with => "asd")
  # #   fill_in("user_last_name", :with => "asdf")
  # #   click_button("Update")
  # #   page.should have_content("Your account information has been updated.")
  # #   page.should have_content("asd asdf")
  # # end

  # scenario "update a users bike" do
  #   # bike = FactoryGirl.create :bmw, user: logged_in_user
  #   # visit account_path(User.find_by_name($1))
  #   # sleep 10
  # end
end
