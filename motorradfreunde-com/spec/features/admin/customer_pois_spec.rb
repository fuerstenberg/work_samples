# # encoding: utf-8
# require 'rails_helper'
#
# feature "Admin customer pois" do
#   background do
#     logged_in_admin
#     @customer = FactoryGirl.create :customer
#     check_page "/admin/customers/#{@customer.id}", "Berghotel GmbH"
#   end
#
#   scenario "should show a list of pois" do
#     click_link "POI anlegen"
#   end
#
# end
