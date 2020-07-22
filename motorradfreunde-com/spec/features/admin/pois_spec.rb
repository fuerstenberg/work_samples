# # encoding: utf-8
# require 'rails_helper'
#
# feature "Admin pois" do
#   background do
#     logged_in_admin
#     @customer = FactoryGirl.create :customer
#     FactoryGirl.create :poi, customer: @customer, name: "Bikertreff Berlin"
#     FactoryGirl.create :poi, customer: @customer, name: "Bikertreff Hamburg"
#   end
#
#   scenario "should show a list of pois" do
#     check_page "/admin/pois", "POIs"
#     i_should_see "Bikertreff Berlin"
#     i_should_see "Bikertreff Hamburg"
#   end
#
#   scenario "should be able to create a point of interest", js: true do
#     visit "/admin/customers/#{@customer.id}"
#     click_link "POI anlegen"
#     fill_in "Name",           with: "Ducati"
#     fill_in "Kontakt",        with: "Mario Ducati"
#     fill_in "Kategorie",      with: "Hersteller, Motorradhändler, Zubehörhersteller, Shop, Motorradwerkstatt"
#     fill_in "Leistungen",     with: "Garage, Carport, Schrauberecke, Tourguide, Tourentipps, Chef fährt Motorrad, Trockenraum, Wifi"
#     select  "Deutschland",    from: "poi_country"
#     fill_in "Ort",            with: "Berlin"
#     fill_in "Telefon",        with: "1234567"
#     fill_in "eMail",          with: "kontakt@ducati.it"
#     fill_in "Postleitzahl",   with: "14521"
#     fill_in "Straße",         with: "Ducstreet 2"
#     fill_in "Fax",            with: "145214785"
#     fill_in "Internetseite",  with: "http://www.ducati.it"
#     fill_in "Beschreibung",   with: "Nice bikes"
#     fill_in "Öffnungszeiten", with: "In winter only"
#     fill_in "Breitengrad",    with: "52"
#     fill_in "Längengrad",     with: "13"
#     fill_in "Logfile",        with: "whenever"
#     click_button "POI anlegen"
#     i_should_see "POI was successfully created."
#   end
# end
