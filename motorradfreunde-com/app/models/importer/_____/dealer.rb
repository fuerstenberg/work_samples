require 'nokogiri'
require 'open-uri'

class Importer::________::Dealer < Poi

  validates :http,       uniqueness: true, presence: true
  validates :import_url, uniqueness: true, presence: true

  URL = "http://________.de"

  def self.import
    url = [URL, "motorrad-haendler"].join("/")
    p url
    doc = Nokogiri::HTML open(url)
    doc.css('#col-left .field .linklist').each do |linklist|
      linklist.css('li a').each do |link|
        self.new({
          name:       link.content,
          import_url: [URL, link.attr('href')].join('/') # http://markt.motorradonline.de/haendler-454996-fahr-werk-loretter-peter
        })
      end
    end
  end

  def initialize(attributes)
    super attributes
    self.import
    puts self.to_s
    unless self.save
      puts self.errors.full_messages
    end
    sleep 1
  rescue => e
    p e
    nil
  end

  def import
    p self.import_url
    doc = Nokogiri::HTML open(self.import_url)
    self.http = doc.css('#dpf-contact .name a').first().attr('href')
    self.fax = doc.css('#dpf-contact .fax').first().content.squish rescue nil
    self.phone = doc.css('#dpf-contact .tel').first().content.squish rescue nil
    self.find_address doc.css('#dpf-contact .adress').first().content.split("\r\n").map(&:squish).select(&:present?).join(', ')
    self.tag_list = doc.css('#dpf-position #dpf-container .contentbox.leistungen ul.tableList li').map do |tag|
      tag.content.squish
    end
  end

  def find_address(query)
    if geo = Geocoder.search(query) and not geo.empty?
      geo = geo.first
      self.city      = geo.city
      self.country   = geo.country
      self.street    = [geo.route, geo.street_number].select(&:present?).join(' ')
      self.zip       = geo.postal_code
      self.latitude  = geo.latitude
      self.longitude = geo.longitude
    end
  end

end
