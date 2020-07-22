class Message

  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :conversation
  belongs_to :sender,    class_name: 'User' # , foreign_key: :sender_id
  belongs_to :recipient, class_name: 'User' # , foreign_key: :receiver_id

  field :body,                       type: String
  field :opened,                     type: Boolean, default: false
  field :recipient_delete,           type: Boolean, default: false
  field :recipient_permanent_delete, type: Boolean, default: false
  field :sender_delete,              type: Boolean, default: false
  field :sender_permanent_delete,    type: Boolean, default: false

  after_create :set_recent_message_time
  after_create :fire_notification_after_create

  def close
    set opened: false
  end
  alias :mark_as_unread :close
  alias :unread         :close

  def open
    set opened: true
  end
  alias :mark_as_read :open
  alias :read         :open

  def open?
    self.opened?
  end

  private

  # after_create
  def fire_notification_after_create
    Notification.fire({
      parent:  conversation,
      subject: self,
      type:    'message.create',
      users:   self.conversation.members_without(self.sender),
    })
  end

  # after_create
  def set_recent_message_time
    conversation.set_recent_message_time!
  end

end
