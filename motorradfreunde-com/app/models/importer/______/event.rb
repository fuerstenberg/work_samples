require 'nokogiri'
require 'open-uri'

class Importer::_________::Event < Event

  validates :import_url, uniqueness: true, presence: true

  def self.import
    url = "http://www.___________"
    doc = Nokogiri::HTML open(url + "/termine/")
    doc.css("table.gkPager tr td[align='center'] a").map{|e| e.attr('href') }.uniq.each do |page|
      doc = Nokogiri::HTML open(url + page)
      doc.css("table.gkTab.gkTabRaceevents tbody tr")
      doc.css("table.gkTab.gkTabRaceevents tbody tr").each do |event|
        dates = event.css("td:nth-child(1)").text.split("-").each(&:squish!)
        if dates.size == 2
          end_at = Date.parse dates[1]
          start_at = Date.parse dates[0] + end_at.year.to_s
        else
          start_at = end_at = Date.parse dates[0]
        end

        import_url = url + event.css("td:nth-child(2) a").attr('href').value
        title = event.css("td:nth-child(2) a").text
        tags = event.css("td:nth-child(2) span.label").map &:text

        doc = Nokogiri::HTML open(import_url)
        full_address = doc.css(".gkPageBoxCont").detect{|box| box.css('#gkMap').size == 1 }.css("div:nth-child(2)").text.split("\n").each(&:squish!).select{|line| line.present? and !line.starts_with?("http")}.join(", ")
        http = doc.css(".gkPageBoxCont").detect{|box| box.css('#gkMap').size == 1 }.css("a").attr("href").value rescue nil


        puts "---------------------------------"
        puts "---------------------------------"
        puts title
        puts full_address
        puts tags
        puts start_at
        puts end_at
        puts http
        puts import_url

      end
    end

  end
end
