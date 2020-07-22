# require 'rails_helper'
#
# feature "Feedback" do
#   background do
#     user = a_admin
#     user.id = 1
#     user.save!
#     user.id.should == 1
#     logged_in_user
#   end
#
#   scenario "send feedback" do
#     visit '/pois'
#     click_on "Feedback"
#     fill_in "message_body", with: "This is my feedback."
#     click_on "Nachricht senden"
#     i_should_see "Deine Nachricht wurde erfolgreich versendet."
#     Message.last.body.should == "This is my feedback."
#   end
#
# end
