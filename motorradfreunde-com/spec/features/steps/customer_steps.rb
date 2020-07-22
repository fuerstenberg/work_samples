# encoding: utf-8

def fill_in_customer_data
  fill_in "Firmenname",      with: "Berghotel GmbH"
  fill_in "Ansprechpartner", with: "Bernhard Beinhart"
  fill_in "eMail",           with: "b.beinhart@gmail.com"
  fill_in "Straße",          with: "Berghotelstrasse 1"
  fill_in "Ort",             with: "Alpenberg"
  fill_in "Postleitzahl",    with: "12345"
  select  "Deutschland",     from: "Land"
  fill_in "Telefon",         with: "01234 567890"
  fill_in "Fax",             with: "01234 567890"
  fill_in "Anmerkungen",     with: "Rechnung bitte per Fax senden."
end
