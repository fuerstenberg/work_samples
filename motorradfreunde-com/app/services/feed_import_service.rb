class FeedImportService

  def initialize(feed)
    @feed = feed
    import
  end

  def self.import
    Poi.with_feeds.each do |poi|
      poi.feeds.each do |feed|
        new feed
      end
    end
  end

  def import
    @feed.import_feed_items
  end

end
