require 'nokogiri'
require 'open-uri'

namespace :import do
  desc "Import alpine passes"
  task :alpine_passes => :environment do
  	(0..52).each do |page|
  		print "\n Parsing Page #{page +1 } of 53 \n"
  		url = "http://*************************.html?pg=#{page + 1}"
  		doc = Nokogiri::HTML open(url)

  		content_links = []
  		content_links << doc.css('table .descr a').map{ |link| link.attributes["href"].value.gsub("..", "http://www.bi-----------ff.de") }
  		content_links.flatten!

  		pois = content_links.inject([]) do |pois, url|
  			url = "http://__________.de/#{url}"
  			doc = Nokogiri::HTML(open(url).read, nil, 'utf-8')
        doc.encoding = 'utf-8'
  			name        =  doc.css("table h1").text.strip
  			description =  doc.css("#tab_properties p").text.gsub /\u00A0/, ''
  			lat					=  doc.css("#clat").text
  			lng					=  doc.css("#clon").text
  			city    		=  doc.css("#tab_properties td a")[1].text
  			country     =  doc.css("#tab_properties td b").text
  			images      =  doc.css("#tab_images td a").map {|link| "http://_______________.de" + link.attributes["href"].value}

  			np = Poi.new({
  				:name => name,
  				:description => description,
  				:lat => lat,
  				:lng => lng,
  				:city => city,
  				:http => url,
  				:country => country
  				})

        # this prevents loading the images if poi already exists
  			unless Poi.find_by_name_and_city(name, city)

  				if images.present?
  					images.each do |image|
  						photo = np.photos.build(:photo => open(image))
  					end
  				end

    			if np.save
    			  putc "."
    			else
    			  p np.errors.full_messages
    			end
    		else
    			putc "."
    		end
    	end
  	end
  end
end
