class TreffenOnlineImportService

  def initialize(url:)
    @url = url
  end

  def self.process
    (0..10).each do |page|
      puts "Page: #{page}"
      url = "http://www.treffen-online.de/motorrad/kalender/kalender.php?kal_Start=#{(page*50)+1}"
      doc = Nokogiri::HTML open(url)
      doc.css('table.kalList tr').each do |data|
        if ['kalDat1', 'kalDat2'].include?(data.css('td').first.attr('class'))
          new( url: "http://www.treffen-online.de#{data.css('td:nth-child(3) a.kalDetl').attr('href').value}" ).process
        end
      end
      sleep 1
    end
  end

  def process
    puts "++++++++++++++++++++++++++++++++++++++++++"
    puts @url

    event = Event.find_or_initialize_by({ foreign_id: foreign_id }) do |event|
      event.start_at       = start_at
      event.end_at         = end_at
      event.title          = title
      event.description    = description
      event.user           = user
      event.url            = website
      event.address.city   = city
      event.address.street = street
      event.address.zip    = zip
      event.import_url     = import_url
    end

    if event.save
      puts "SUCCESS: "
      puts event.inspect
    else
      puts "ERRORS: "
      puts event.errors.full_messages
    end
    sleep 1
  end

  private

  def city
    data["Wohnort"]
  end

  def comment
    data["Kommentar"]
  end

  def contact
    data['Kontaktname']
  end

  def data
    return @data if defined?(@data)
    doc = Nokogiri::HTML open(@url)
    @data = doc.css('.kalBox table.kalDetl tr').inject({}) do |result, tr|
      result[ tr.css('td:nth-child(1)').text.squish ] = tr.css('td:nth-child(2)').text.squish
      result
    end
  end

  def description
    [comment, contact, phone].join("\n\r\n\r")
  end

  def end_at
    Date.parse data['Ende'].squish
  end

  def foreign_id
    ['treffen-online', data['Nummer'].squish ].join('-')
  end

  def import_url
    @url
  end

  def normalize_url(url)
    return "" unless url.present?
    if url.starts_with?('http://')
      url
    else
      "http://#{url}"
    end
  end

  def phone
    data["Telefon"]
  end

  def start_at
    Date.parse data['Datum'].squish
  end

  def street
    data["Strasse"]
  end

  def title
    [ data['Club'], data['Veranstaltung'] ].select(&:present?).join(' - ')
  end

  def user
    User.find_by slug: 'werner-7'
  end

  def website
    normalize_url data["Url"]
  end

  def zip
    data['PLZ']
  end

end
