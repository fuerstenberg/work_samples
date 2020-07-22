# encoding: utf-8

def fill_in_poi_data
  fill_in "Name",            with: "Motorradfreunde.com"
  fill_in "Kontakt",         with: "Bernhard Beinhart"
  check "Bikertreff"
  select  "Deutschland",     from: "Land"
  fill_in "Postleitzahl",    with: "12345"
  fill_in "Ort",             with: "Alpenberg"
  fill_in "Straße",          with: "Berghotelstrasse 1"
  fill_in "Telefon",         with: "030 49852530"
  fill_in "Mobilnummer",     with: "0171 5253466"
  fill_in "Fax",             with: "030 49852532"
  fill_in "Internetseite",   with: "http://www.motorradfreunde.com"
  fill_in "eMail",           with: "rene.fuerstenberg@gmail.com"
  fill_in "Beschreibung",    with: "Deine Motorradtreff im Internet"
  fill_in "Öffnungszeiten",  with: "Rund um die Uhr"
  attach_file "Bild 1", "spec/support/testbild.png"
  attach_file "Bild 2", "spec/support/testbild.png"
  attach_file "Bild 3", "spec/support/testbild.png"
end
