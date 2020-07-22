class Release

  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :screen
  embedded_in :content

  delegate :customer, to: :content

  # field :end_at,   type: DateTime
  # field :order,    type: Integer, default: 0
  # field :start_at, type: DateTime

  validates :screen_id, uniqueness: true

  # def state
  #   now = Time.now
  #   if start_at.nil?
  #     :unpublished
  #   elsif start_at <= now
  #     :published
  #   elsif start_at > now
  #     :scheduled
  #   end
  # end

end
