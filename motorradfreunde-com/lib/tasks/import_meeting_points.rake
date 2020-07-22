require 'nokogiri'
require 'open-uri'


namespace :import do
  desc "Import meeting points"
  task :meeting_points => :environment do


  content_links = []

  (0..30).each do |site|
    url = "http://_________________________/Deutschland&localparams=1&range=#{site * 20},20"
    doc = Nokogiri::HTML open(url)
    content_links << doc.css('table[cellspacing="2"] a').map{ |link| link.attributes["href"].value }
  end

  content_links.flatten!

  pois = content_links.inject([]) do |pois, url|
    doc = Nokogiri::HTML open(url)
    poi = doc.css('table[cellpadding="4"] tr').inject({}) do |poi, tr|
      poi[tr.search('td:nth-child(1)')[0].content] = tr.search('td:nth-child(2)')[0].content
      poi
    end

    p poi["PLZ:"] + " " + poi["Ort:"] + ", " + poi["Strasse:"]
    if result = Geokit::Geocoders::MultiGeocoder.geocode(poi["PLZ:"] + " " + poi["Ort:"] + ", " + poi["Strasse:"]) and result.success
      poi["lat"]      = result.lat
      poi["lng"]      = result.lng
      poi["country"]  = result.country
    elsif result = Geokit::Geocoders::MultiGeocoder.geocode(poi["PLZ:"] + " " + poi["Ort:"]) and result.success
      poi["lat"]      = result.lat
      poi["lng"]      = result.lng
      poi["country"]  = result.country
    elsif result = Geokit::Geocoders::MultiGeocoder.geocode(poi["Ort:"]) and result.success
      poi["lat"]      = result.lat
      poi["lng"]      = result.lng
      poi["country"]  = result.country
    elsif result = Geokit::Geocoders::MultiGeocoder.geocode("Deutschland, " + poi["PLZ:"]) and result.success
      poi["lat"]      = result.lat
      poi["lng"]      = result.lng
      poi["country"]  = result.country
    end

    np = Poi.new({
      name:             poi["Name:"],
      street:           poi["Strasse:"],
      zip:              poi["PLZ:"],
      city:             poi["Ort:"],
      country:          poi["country"],
      phone:            poi["Telefon:"],
      fax:              poi["Fax:"],
      handy:            poi["Handy:"],
      email:            poi["EMail:"],
      http:             poi["Homepage:"],
      description:      poi["Kommentar:"],
      lat:              poi["lat"],
      lng:              poi["lng"],
      is_meeting_point: true
    })
    if np.save
      putc "."
    else
      p np.inspect
    end

    sleep 1

    pois << poi
    pois
  end

  # p pois.inspect
  end
end
