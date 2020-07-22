class Bike

  include Mongoid::Document
  include Mongoid::Search
  include Mongoid::Timestamps

  include Concerns::EmbedsManyComments
  include Concerns::EmbedsManyImages
  include Concerns::HasImpressions
  include Concerns::HasMetaMethods
  include Concerns::HasManyActivities
  include Concerns::HasDefaultScopes

  # TODO: belongs_to :poi #, touch: true, counter_cache: true
  belongs_to :vendor, class_name: 'Poi', counter_cache: true, foreign_key: 'poi_id'
  belongs_to :user

  scope :by_vendor, -> poi_id { where(poi_id: Poi.find_by(slug: poi_id).id) }

  field :vendor_name,         type: String
  field :model,               type: String
  field :ccm,                 type: Integer
  field :hp,                  type: Integer
  field :year_of_manufacture, type: DateTime
  field :color,               type: String
  field :description,         type: String
  field :category,            type: String
  field :property,            type: String
  field :permalink,           type: String

  validates :poi_id, presence: true
  validates :model,  presence: true
  validates :ccm,    numericality: true, if: lambda{|o| o.ccm.present?}
  validates :hp,     numericality: true, if: lambda{|o| o.hp.present?}

  acts_as_url :model, url_attribute: :slug

  search_in :full_name, :year_of_manufacture, :description #, :name, :tags => :name, :category => :name, :info => [:summary, :description]

  def full_name
    [vendor, model].join(" ")
  end

  def to_description
    self.description[0,155] rescue ""
  end

  def to_keywords
    [self.vendor_name || self.vendor.try(:to_s), self.model, "#{self.ccm} ccm", "#{self.hp} PS", self.year_of_manufacture].join(',') rescue nil
  end

  def to_param
    slug
  end

  def to_s
    full_name
  end

  def to_subtitle
    self.to_s
  end

  def to_title
    self.to_s
  end

  def year_of_manufacture
    self[:year_of_manufacture].year.to_i
  rescue
    super
  end

  def year_of_manufacture=(value)
    if value.is_a?(Date) or value.is_a?(DateTime)
      super value
    else
      self[:year_of_manufacture] = DateTime.parse "#{value}-01-01"
    end
  end

end
