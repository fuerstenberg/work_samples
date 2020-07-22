require 'nokogiri'
require 'open-uri'


namespace :import do
  desc "Import motorradfreunde in pois"
  task :mf => :environment do
    result = []

    url = "http://www._____________________.htm"
    doc = Nokogiri::HTML open(url)
    doc.encoding = 'UTF-8'

    # result << doc.css('table[cellspacing="2"] a').map{ |link| link.attributes["href"].value }
    doc.css('table tr').each do |row|
      poi = {}

      poi['name']   = row.css('td:nth-child(1) a').first.content.squish rescue nil
      poi['http']   = row.css('td:nth-child(1) a').first.attributes["href"].value rescue nil
      poi['email']  = row.css('td:nth-child(2) a').first.attributes["href"].value.gsub('mailto:', '') rescue nil
      poi['zip']    = row.css('td:nth-child(3)').first.content.squish rescue nil

      poi['name'].gsub!('MF ', 'Motorradfreunde ') if poi['name']
      poi['name'].gsub!(' MF', ' Motorradfreunde') if poi['name']
      poi['name'].gsub!('MF-', 'Motorradfreunde-') if poi['name']

      poi['is_social_club'] = true

      if poi['name'].present? and poi['http'].include?('http://')
        poi = Poi.new poi
        poi.save validate: false
        p poi
      end
    end
  end

  desc "Import motorradclubs in pois"
  task :mc => :environment do
    result = []

    url = "http://www.______________________.htm"
    doc = Nokogiri::HTML open(url)
    doc.encoding = 'UTF-8'

    # result << doc.css('table[cellspacing="2"] a').map{ |link| link.attributes["href"].value }
    doc.css('table tr').each do |row|
      poi = {}

      poi['name']   = row.css('td:nth-child(1) a').first.content.squish rescue nil
      poi['http']   = row.css('td:nth-child(1) a').first.attributes["href"].value rescue nil
      poi['email']  = row.css('td:nth-child(2) a').first.attributes["href"].value.gsub('mailto:', '') rescue nil
      poi['zip']    = row.css('td:nth-child(3)').first.content.squish rescue nil

      # poi['name'].gsub!('MF ', 'Motorradfreunde ') if poi['name']
      # poi['name'].gsub!(' MF', ' Motorradfreunde') if poi['name']
      # poi['name'].gsub!('MF-', 'Motorradfreunde-') if poi['name']

      poi['is_motorcycle_club'] = true

      if poi['name'].present? and poi['http'].include?('http://')
        poi = Poi.new poi
        poi.save validate: false
        p poi
      end
    end
  end
end
