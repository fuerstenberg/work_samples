class Notification

  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :parent,  polymorphic: true
  belongs_to :subject, polymorphic: true, inverse_of: :notifications_as_subject
  belongs_to :user, inverse_of: :notifications

  scope :unread,  -> { where(read: false) }
  scope :greeted, -> { where(notification_type: 'user.greet') }
  scope :today,   -> { where(created_at: (Time.now.beginning_of_day..Time.now.end_of_day)) }

  # TODO: default_scope { order 'created_at DESC' }

  # TODO: notification callbacks
  # after_create :send_email
  # after_create :send_facebook_message

  field :notification_type, type: String
  field :read,              type: Boolean, default: false

  validate :user_greeting

  def self.fire(options = {})
    [options[:users]].flatten.compact.uniq.each do |user|
      user.notifications.create({
        subject:           options[:subject],
        parent:            options[:parent],
        notification_type: options[:type]
      })
    end
  end

  def self.read!
    update_all read: true
  end

  def read!
    update_attribute :read, true
  end

  def actor
    if self.subject.is_a?(User)
      self.subject
    else
      self.subject.user
    end
  rescue
    nil
  end

  def commentable
    self.subject.commentable if self.subject.respond_to?(:commentable)
  end

  def to_s
    self.subject
  end

  private

  def user_greeting
    if self.notification_type == 'user.greet'
      existing = Notification.greeted.today.where(
        user_id:    self.user.id,
        subject_id: self.subject.id
      )
      if existing.present?
        errors.add(:subject_id, 'already greeted user today')
      end
    end
  end

  def send_email
    case self.notification_type
    when 'user.greet'
      return true if self.user.notifications.greeted.today.count > 0
    when 'ride_request_created'
      if self.subject.present? and self.user.present? and self.actor.present? and !self.subject.deleted?
        UserMailer.notification_mail(self).deliver
      end
    else
      if self.subject.present? and self.user.present? and self.actor.present?
        UserMailer.notification_mail(self).deliver
      end
    end
  end
  handle_asynchronously :send_email, run_at: Proc.new { 10.minutes.from_now }

  def send_facebook_message
    return if !self.actor.respond_to?(:facebooker?) or !self.actor.facebooker?
    graph = Koala::Facebook::API.new(self.actor.oauth_token)
    case self.notification_type
    when 'user.greet'
      graph.put_connections "me", "feed", I18n.t('notifications.facebook.user_greeted') if self.actor.notifications_as_subject.greeted.today.count < 1
    when 'ride_request_created'
      graph.put_connections "me", "feed", I18n.t('notifications.facebook.ride_request_created') if self.subject and !self.subject.deleted?
    end
  rescue => error
    logger.error error
  end
  handle_asynchronously :send_facebook_message, run_at: Proc.new { 10.minutes.from_now }

end
