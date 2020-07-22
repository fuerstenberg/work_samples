class RideRequest

  include Mongoid::Document
  include Mongoid::Timestamps

  include Concerns::EmbedsManyComments
  include Concerns::EmbedsOneAddress
  include Concerns::HasImpressions
  include Concerns::HasMetaMethods
  include Concerns::HasManyActivities

  belongs_to :user

  field :deleted,       type: Boolean, default: false
  field :driving_style, type: String
  field :start_at,      type: DateTime

  validate :start_at_only_once_per_user
  validates :start_at, presence: true

  # TODO: default_scope { order :start_at }
  scope :upcoming,    -> { where(start_at: (Time.now.beginning_of_day..Time.now.end_of_day+10.days)) }
  scope :deleted,     -> { where(deleted: true) }
  scope :not_deleted, -> { where(deleted: false) }

  before_validation :copy_address_from_user

  def self.for_date?(date)
    self.not_deleted.detect{|ride_request| ride_request.start_at.to_date == date }
  end

  def to_s
    I18n.t "ride_request.to_s", user: self.user.to_s
  end

  private

  def copy_address_from_user
    if self.user and self.user.address
      self.address = self.user.address.dup
    end
  end

  def start_at_only_once_per_user
    if !self.user or self.user.ride_requests.not_deleted.where(start_at: self.start_at, 'id.neq' => self.id).exists?
      errors.add :start_at, I18n.t("activerecord.errors.messages.taken")
    end
  end

end
