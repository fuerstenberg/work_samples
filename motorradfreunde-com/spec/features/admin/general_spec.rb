# # encoding: utf-8
# require 'rails_helper'
#
# feature "Admin in general" do
#
#   background do
#     logged_in_admin
#     check_page "/admin", "Übersicht"
#   end
#
#   scenario "should have some links", js: true do
#     within ".meta_navigation ul.nav" do
#       click_link @current_user.to_s
#       click_link 'Übersicht'
#
#       click_link @current_user.to_s
#       click_link 'Kunden'
#
#       click_link @current_user.to_s
#       click_link 'POIs'
#
#       click_link @current_user.to_s
#       click_link 'Werbeanzeigen'
#
#       click_link @current_user.to_s
#       click_link 'Artikel'
#
#       click_link @current_user.to_s
#       click_link 'Biker'
#
#       click_link @current_user.to_s
#       click_link 'Feeds'
#
#       click_link @current_user.to_s
#       click_link 'Termine'
#
#       click_link @current_user.to_s
#       click_link 'Jobs'
#
#       click_link @current_user.to_s
#       click_link 'Statistik'
#
#       click_link @current_user.to_s
#       i_should_see "Analytics"
#       i_should_see "Adwords"
#       i_should_see "Adsense"
#       i_should_see "Monit"
#       i_should_see "Facebook"
#     end
#   end
#
# end
