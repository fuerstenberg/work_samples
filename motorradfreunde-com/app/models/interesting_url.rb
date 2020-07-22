class InterestingUrl

  include Mongoid::Document
  include Mongoid::Timestamps

  field :url,        type: String
  field :checked_at, type: DateTime

  validates :url, uniqueness: true, presence: true

  def to_s
    self.url
  end

  def host
    self.parse.host
  end

  def parse
    URI.parse self["url"].starts_with?("http") ? self["url"] : "http://"+self["url"]
  end

  def url
    uri = self.parse
    uri.scheme ||= "http"
    uri.to_s
  end

end
