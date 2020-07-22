# # encoding: utf-8
# require 'rails_helper'
#
# feature "Pages" do
#
#   background do
#   end
#
#   scenario "only 3 pages should be shown when i am an anonymous user" do
#   end
#
#   scenario "show never a page for a logged out facebook user" do
#   end
#
#   scenario "show never a page for a logged out, but registered user" do
#   end
#
#   scenario "should be accessible for anonymous users" do
#     check_page "/",                         "Motorradfreunde.com - Dein Bikertreff im Internet"
#     check_page "/account/register/sign_up", "Benutzerkonto erstellen"
#     check_page "/users/login",              "Anmelden"
#     check_page "/dashboards",               "Anmelden"
#     check_page "/pois",                     "Anmelden"
#     check_page "/routes",                   "Anmelden"
#     check_page "/users",                    "Anmelden"
#     check_page "/bikes",                    "Anmelden"
#     check_page "/events",                   "Anmelden"
#     check_page "/articles",                 "Anmelden"
#     check_page "/questions",                "Anmelden"
#     check_page "/videos",                   "Anmelden"
#     check_page "/page/partner",             "Partner werden"
#     check_page "/page/impress",             "Impressum"
#     check_page "/page/terms",               "Allgemeine Geschäftsbedingungen"
#     check_page "/page/banners",             "Werbebanner"
#   end
#
#   scenario "all pages should be shown when iam logged in, except admin pages" do
#     logged_in_user
#     check_page "/",             "Kartenansicht"
#     check_page "/dashboards",   "Neuigkeiten"
#     check_page "/pois",         "POIs"
#     check_page "/routes",       "Routen"
#     check_page "/users",        "Biker"
#     check_page "/bikes",        "Bikes"
#     check_page "/events",       "Termine"
#     check_page "/articles",     "Artikel"
#     check_page "/questions",    "Forum"
#     check_page "/videos",       "Videos"
#     check_page "/page/partner", "Partner werden"
#     check_page "/page/impress", "Impressum"
#     check_page "/page/terms",   "Allgemeine Geschäftsbedingungen"
#     check_page "/admin",        "Karte wird geladen..."
#   end
#
#   scenario "should be accessible for logged in admins" do
#     logged_in_admin
#     check_page "/admin", "Übersicht"
#   end
#
# end
