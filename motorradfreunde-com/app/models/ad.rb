class Ad

  include Mongoid::Document
  include Mongoid::Timestamps

  include Concerns::HasImpressions

  belongs_to :customer, counter_cache: true

  TARGETS = {
    sidebar:     "Sidebar",
    list:        "Listen",
    detail_page: "Detailseite"
  }

  field :active,        type: Boolean, default: false
  field :description,   type: String
  field :displayed_url, type: String
  field :html_only,     type: Boolean, default: false
  field :html,          type: String
  field :javascript,    type: String
  field :position,      type: Integer
  field :subtitle,      type: String
  field :target,        type: String
  field :title,         type: String
  field :url,           type: String

  validates :customer, presence: true
  validates :title,    presence: true
  validates :target,   presence: true
  validates :url,      allow_blank: true, url: true

  scope :active, -> { where(active: true) }

  def self.prioritized
    position = false
    self.active.order(target: :asc, position: :desc).to_a.inject({}) do |result,ad|
      result[ad.target.to_s] ||= []
      result[ad.target.to_s] << [] if position != ad.position
      result[ad.target].last << ad
      result[ad.target].last.shuffle!
      result
    end
  end

  def from_affiliate?
    !(title.present? and url.present? and subtitle.present?)
  end

  def to_s
    title
  end

end
