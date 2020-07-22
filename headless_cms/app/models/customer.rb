class Customer

  include Mongoid::Document
  include Mongoid::Timestamps

  include Concerns::Customer::Roles
  include Concerns::Shared::Address
  include Concerns::Doorkeeper::Owner

  has_many :content_lists, dependent: :restrict_with_error
  has_many :content_trees, dependent: :restrict_with_error
  has_many :content_types, dependent: :restrict_with_error
  has_many :contents,      dependent: :restrict_with_error
  has_many :screens,       dependent: :restrict_with_error

  mount_uploader :logo, LogoUploader

  field :name, type: String

  validates :name, presence: true

  def database_name
    "#{Mongoid.default_client.database.name}_customer_#{self.id.to_s}"
  end

  def recent_updated_content
    Current.customer = self
    contents.order(updated_at: :desc).limit(1).first
    Current.customer = nil
  end

  def to_s
    self.name
  end

end
