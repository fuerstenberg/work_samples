# # encoding: utf-8
# require 'rails_helper'
#
# feature "Admin ads" do
#   background do
#     logged_in_admin
#     @customer = FactoryGirl.create :customer
#     FactoryGirl.create :ad, customer: @customer
#   end
#
#   scenario "should be listed" do
#     check_page "/admin/ads", "Werbeanzeigen"
#     i_should_see "Werbeanzeigen"
#     i_should_see "Google Ad"
#   end
#
#   scenario "should be able to create ads and display them" do
#     visit "/admin/customers/#{@customer.id}"
#     click_link "Werbeanzeige anlegen"
#     within "form#new_ad" do
#       fill_in "Title",       with: "Long Way Round"
#       fill_in "Subtitle",    with: "A real good movie"
#       fill_in "Url",         with: "http://www.long-way-round.de"
#       find(:css, "#ad_target").select "Sidebar"
#       fill_in "Html",        with: "My Html"
#       fill_in "Javascript",  with: "My Javascript"
#       fill_in "Description", with: "My Description"
#       click_button "Ad anlegen"
#     end
#     i_should_see "Ad was successfully created."
#     i_should_see "Long Way Round"
#     i_should_see "A real good movie"
#     i_should_see "http://www.long-way-round.de"
#     i_should_see "sidebar"
#     i_should_see "My Html"
#     i_should_see "My Javascript"
#     i_should_see "My Description"
#   end
# end
