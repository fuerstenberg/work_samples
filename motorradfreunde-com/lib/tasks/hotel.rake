require 'csv'
require 'pp'

namespace :hotel do
  desc "Import Hotels from csv"
  task :import => :environment do
    count = 0
    CSV.readlines("db/poi.csv", :encoding => 'UTF-8', :headers => true).each do |row|

      hotel = Hotel.new
      hotel.name = row['name'].strip
      hotel.lat = row['lat']
      hotel.lng = row['lng']

      if row['address'].match(/\d{5}/)
        hotel.zip = row['address'].match(/\d{5}/)[0]
        hotel.city = row['address'].gsub(/.*?(\d{5})/, '').strip
      elsif row['address'].match(/\d{4}/)
        hotel.city = row['address'].gsub(/.*?(\d{4})/, '').strip
        hotel.zip = row['address'].match(/\d{4}/)[0]
      end

      row['address'] = row['address'].gsub(hotel.city, '') if hotel.city
      row['address'] = row['address'].gsub(hotel.zip, '') if hotel.zip

      if row['address'].match('NL-')
        hotel.country = "Holland"     and row['address'] = row['address'].delete("NL-")
      elsif row['address'].match('F-')
        hotel.country = "Frankreich"  and row['address'] = row['address'].delete("F-")
      elsif row['address'].match('CH-')
        hotel.country = "Schweiz"     and row['address'] = row['address'].delete("CH-")
      elsif row['address'].match('I-')
        hotel.country = "Italien"     and row['address'] = row['address'].delete("I-")
      elsif row['address'].match('A-')
        hotel.country = "Oesterreich" and row['address'] = row['address'].delete("A-")
      elsif row['address'].match('D-')
        hotel.country = "Deutschland" and row['address'] = row['address'].delete("D-")
      else
        hotel.country = "Deutschland"
      end

      hotel.street = row['address'].strip
      hotel.phone = row['phone']

      puts "importiere hotel:"
      puts '-------------'
      puts hotel.name
      puts hotel.country
      puts hotel.city
      puts hotel.street
      puts hotel.phone
      puts '-------------'
      puts "\n"

      if hotel.save
        count += 1
      end
    end
    puts "#{count} Hotels wurden importiert. Danke fuer ihre Geduld."
  end
end
