class Screen

  include Mongoid::Document
  include Mongoid::Timestamps

  include Concerns::Shared::Address
  include Concerns::Doorkeeper::Owner
  include Concerns::Screen::Releases
  include Concerns::Screen::ContentList
  include Concerns::Screen::ContentTree

  belongs_to :customer

  scope :active, ->{ where(last_api_get_request: ((Time.now - 12.hours)..Time.now)) }

  field :name, type: String
  field :last_api_get_request, type: DateTime

  validates :name, presence: true

  def self.grouped_by_month
    screens = active.order(created_at: :asc).to_a
    result = {}
    return result if screens.empty?
    (screens[0].created_at.to_date..Date.today).each do |day|
      result[day.beginning_of_month] ||= []
    end
    screens.each do |screen|
      result[screen.created_at.to_date.beginning_of_month] << screen
      result
    end
    result
  end

  def to_s
    name
  end

  def last_api_get_request_status
    if Time.now < last_api_get_request + 12.hours
      :success
    elsif Time.now < last_api_get_request + 2.days
      :warning
    else
      :danger
    end
  rescue
    :danger
  end

end
