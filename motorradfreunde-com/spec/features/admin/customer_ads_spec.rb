# # encoding: utf-8
# require 'rails_helper'
#
# feature "Admin customer ads" do
#   background do
#     logged_in_admin
#     @customer = FactoryGirl.create :customer
#     @ad = FactoryGirl.create :ad, title: "Berghotel Werbung", customer: @customer
#     check_page "/admin/customers/#{@customer.id}", "Übersicht"
#   end
#
#   scenario "should be listed" do
#     i_should_see @customer.to_s
#     click_link @customer.to_s
#     i_should_see "Berghotel Werbung"
#   end
#
#   scenario "should be able to create an ad" do
#     i_should_see @customer.to_s
#     click_link "Werbeanzeige anlegen"
#     within "form" do
#       check "Active"
#       select "Sidebar",      from: "Target"
#       fill_in "Title",       with: "Berghotel Sommer Spezial"
#       fill_in "Subtitle",    with: "Sonderpreis"
#       fill_in "Url",         with: "http://www.berghotel.de"
#       fill_in "Html",        with: "some html here"
#       fill_in "Javascript",  with: "some js here"
#       fill_in "Description", with: ""
#       click_on 'Speichern'
#     end
#     i_should_see "Ad was successfully created."
#   end
#
# end
