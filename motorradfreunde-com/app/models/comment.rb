class Comment

  include Mongoid::Document
  include Mongoid::Timestamps

  include Concerns::HasAutoHtml
  include Concerns::EmbedsManyComments
  include Concerns::HasManyActivities

  belongs_to :user
  embedded_in :commentable, polymorphic: true # TODO: counter_cache: true

  field :body,      type: String, default: ''
  field :body_html, type: String, default: ''

  validates_presence_of :body
  validates_presence_of :user_id

  # TODO: after_create :touch_commentable
  after_create :fire_notification_after_create

  def body=(text)
    super text
    self[:body_html] = auto_html text
  end

  def to_s
    self.body.truncate 65
  end

  private

  # after_create
  def fire_notification_after_create
    users = [
      self.commentable.try(:user),
      self.commentable.commenters,
      self.user.friends
    ].flatten.uniq - [self.user]
    Notification.fire({
      parent:  self._parent,
      subject: self,
      type:    'comment.create',
      users:   users,
    })
  end

  # def touch_commentable
  #   self.commentable.try(:touch)
  # end

end
