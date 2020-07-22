class TimelineEvent

  include Mongoid::Document
  include Mongoid::Timestamps

  # include Mapable

  belongs_to :actor,              polymorphic: true
  belongs_to :subject,            polymorphic: true
  belongs_to :secondary_subject,  polymorphic: true

  delegate :facebooker?, to: :actor, allow_nil: true

  paginates_per 50

  before_create :complete_associations
  after_create  :send_facebook_message
  after_create  :change_timestamp
  after_create  :add_geo_coordinates

  # TODO: default_scope { order "timeline_events.created_at DESC" }

  scope :filter_articles,  -> { where(event_type: %w(article_created article_comment_created feed_item_created article_photo_uploaded)) }
  scope :filter_questions, -> { where(event_type: %w(question_created answer_created answer_comment_created)) }
  scope :filter_bikes,     -> { where(event_type: %w(bike_created bike_comment_created bike_photo_uploaded)) }
  scope :filter_events,    -> { where(event_type: %w(event_accepted event_created event_declined event_comment_created)) }
  scope :filter_routes,    -> { where(event_type: %w(route_created route_comment_created)) }
  scope :filter_users,     -> { where(event_type: %w(user_created user_photo_uploaded user_comment_created)) }

  scope :article_created,           -> { where(event_type:   'article_created') }
  scope :article_comments,          -> { where(event_type:   'article_comment_created') }
  scope :comments,                  -> { where(subject_type: 'Comment') }
  scope :question_created,          -> { where(event_type:   'question_created') }
  scope :user_created,              -> { where(event_type:   'user_created') }
  scope :bike_created,              -> { where(event_type:   'bike_created') }
  scope :route_created,             -> { where(event_type:   'route_created') }
  scope :feed_item_created,         -> { where(event_type:   'feed_item_created') }
  scope :without_comment_comments,  -> { where('timeline_events.event_type != "comment_comment_created"') }
  scope :today,                     -> { where(created_at: Date.today.beginning_of_day..Date.today.end_of_day) }

  field :actor_id,               type: Integer
  field :actor_type,             type: String
  field :city,                   type: String
  field :country_code,           type: String
  field :country,                type: String
  field :event_type,             type: String
  field :latitude,               type: Float
  field :longitude,              type: Float
  field :postal_code,            type: String
  field :route,                  type: String
  field :secondary_subject_id,   type: Integer
  field :secondary_subject_type, type: String
  field :state_code,             type: String
  field :state,                  type: String
  field :street_number,          type: String
  field :subject_id,             type: Integer
  field :subject_type,           type: String

  def self.filter_by_type(filter_type)
    case filter_type
    when 'articles'  then self.filter_articles
    when 'questions' then self.filter_questions
    when 'bikes'     then self.filter_bikes
    when 'events'    then self.filter_events
    when 'routes'    then self.filter_routes
    when 'users'     then self.filter_users
    else
      self
    end
  end

  def complete_associations
    self.actor ||= self.subject
    self.secondary_subject ||= self.subject
    self.secondary_subject ||= self.actor
    self.secondary_subject = nil if self.actor == self.subject and self.subject.is_a?(User) and self.event_type == "user_created" # must be nil for new created users
  end

  def change_timestamp
    if self.event_type == 'feed_item_created'
      self.class.update self.id, updated_at: self.subject.published_at, created_at: self.subject.published_at
    end
  end

  def to_s
    "#{event_type} at #{subject} - #{created_at}"
  end

  def send_facebook_message
    return if !actor.respond_to?(:facebooker?) or !self.facebooker?
    graph = Koala::Facebook::API.new(self.actor.oauth_token)
    case self.event_type
    when 'user_created'
      graph.put_connections "me", "feed", I18n.t('timeline_events.facebook.user_created')
    when 'bike_created'
      graph.put_connections "me", "feed", I18n.t('timeline_events.facebook.bike_created') if self.actor.timeline_events.bike_created.today.count < 6 # because of after_create
    end
  rescue => error
    logger.error error
  end

  def add_geo_coordinates
    obj = if subject.respond_to?(:geocoded?) and subject.geocoded?
      subject
    elsif secondary_subject.respond_to?(:geocoded?) and secondary_subject.geocoded?
      secondary_subject
    elsif actor.respond_to?(:geocoded?) and actor.geocoded?
      actor
    end
    if obj
      self.latitude = obj.latitude
      self.longitude = obj.longitude
      self.save!
    end
  end

end
