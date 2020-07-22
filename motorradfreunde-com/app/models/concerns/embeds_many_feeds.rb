module Concerns::EmbedsManyFeeds

  extend ActiveSupport::Concern

  included do
    embeds_many :feeds, cascade_callbacks: true

    accepts_nested_attributes_for :feeds, allow_destroy: true, reject_if: lambda{|o| o["feed_url"].blank? }

    scope :with_feeds, -> { where(:feeds.ne => nil) }
  end

end
