class Customer

  include Mongoid::Document
  include Mongoid::Timestamps

  has_many :ads,              dependent: :destroy
  has_many :customer_notices, dependent: :destroy
  has_many :pois,             dependent: :destroy

  before_validation :generate_token

  field :ads_count,              type: Integer
  field :advertised_by_email_at, type: DateTime
  field :advertised_by_fax_at,   type: DateTime
  field :city,                   type: String
  field :contact,                type: String
  field :country,                type: String
  field :description,            type: String
  field :email,                  type: String
  field :fax,                    type: String
  field :log,                    type: String
  field :name,                   type: String
  field :phone,                  type: String
  field :pois_count,             type: Integer
  field :street,                 type: String
  field :token,                  type: String
  field :url,                    type: String
  field :zip,                    type: String

  validates :url, presence: true, uniqueness: true, url: true
  validates :email, email: true, allow_blank: true

  def address
    [
      self.country,
      [self.zip, self.city].join(' '),
      self.street
    ].select(&:present?).join(', ')
  end

  def to_s
    self.name || self.url
  end

  def deliver_advertising_email
    CustomerMailer.delay.advertising_email(self)
    self.touch :advertised_by_email_at
  end

  private

  def generate_token
    if self.token.blank?
      begin
        token = SecureRandom.urlsafe_base64
      end while Customer.where(:token => token).exists?
      self.token = token
    end
  end

end
