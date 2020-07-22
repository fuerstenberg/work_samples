class Route

  include Mongoid::Document
  include Mongoid::Search
  include Mongoid::Timestamps

  include Concerns::EmbedsOneAddress
  include Concerns::EmbedsManyComments
  include Concerns::HasImpressions
  include Concerns::HasMetaMethods
  include Concerns::HasManyActivities
  include Concerns::HasDefaultScopes

  embeds_many :waypoints, cascade_callbacks: true

  belongs_to :routable, polymorphic: true
  belongs_to :user

  # TODO: serialize :elevation

  index created_at: -1

  field :description,          type: String
  field :distance,             type: Integer
  field :end_address,          type: String
  field :name,                 type: String
  field :start_address,        type: String
  field :static_polyline,      type: String

  delegate :preview, to: :address

  acts_as_url :name, url_attribute: :slug

  search_in :name, :description # start_address: [:zip, :city, :country, :street], end_address: [:zip, :city, :country, :street]

  validates :name, presence: true

  # before_save :normalize_waypoints

  def distance_in_km
    (distance/1000).round
  end

  def to_description
    self.description
  end

  def to_keywords
    self.to_s
  end

  def to_param
    slug
  end

  def to_s
    name.present? ? name : "Route #{id}"
  end

  def to_subtitle
    "#{self.distance_in_km} km"
  end

  def to_title
    self.to_s
  end

  # def normalize_waypoints
  #   self.waypoints = YAML.parse(self.waypoints) if self.waypoints.is_a?(String)
  #   self.waypoints = (self.waypoints || []).inject({}) do |waypoints, waypoint|
  #     waypoints[waypoints.length] = waypoint
  #     waypoints
  #   end
  # end

end
