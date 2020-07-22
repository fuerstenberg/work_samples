class Event

  include Mongoid::Document
  include Mongoid::Search
  include Mongoid::Timestamps

  include Concerns::EmbedsOneAddress
  include Concerns::HasAutoHtml
  include Concerns::EmbedsManyComments
  include Concerns::HasImpressions
  include Concerns::HasMetaMethods
  include Concerns::HasManyActivities

  belongs_to :user

  delegate :admin?, to: :user, allow_nil: true

  scope :past,           -> { where(start_at: ((Date.today-100.years).to_time..Date.yesterday.to_time)) }
  scope :upcoming,       -> { where(start_at: (Date.today..Date.today.next_year)).order(start_at: :asc) }
  scope :next_week,      -> { where(start_at: (Date.today.beginning_of_day..(Date.today + 7.days).end_of_day)).order(start_at: :asc) }
  scope :upcoming_since, ->(date) { where(start_at: (date..date.next_year)).order(start_at: :asc) }

  field :description,            type: String
  field :description_html,       type: String
  field :end_at,                 type: Date
  field :foreign_id,             type: String
  field :hide_time,              type: Boolean, default: false
  field :import_url,             type: String
  field :start_at,               type: Date
  field :title,                  type: String
  field :url,                    type: String

  before_validation :add_url_protocol
  before_validation :change_end_at
  before_validation :set_time_to_full_days_for_hidden_time_option

  validates_presence_of :description
  validates_presence_of :start_at
  validates_presence_of :title

  acts_as_url :title, url_attribute: :slug

  search_in :title, :description, address: [:zip, :city, :country, :street]

  def description=(text)
    super text
    self[:description_html] = auto_html text
  end

  def object_type
    self.class.to_s
  end

  def to_s
    title
  end

  def to_param
    slug
  end

  def user_name
    user.name rescue ""
  end

  private

  def change_end_at
    self.end_at = self.start_at if self.end_at.blank? or self.end_at < self.start_at
  end

  def set_time_to_full_days_for_hidden_time_option
    if self.hide_time
      self.start_at = self.start_at.beginning_of_day
      self.end_at   = self.end_at.end_of_day
    end
  end

  def add_url_protocol
    return true if self.url.blank?
    unless self.url[/\Ahttp:\/\//] || self.url[/\Ahttps:\/\//]
      self.url = "http://#{self.url}"
    end
  end

end
