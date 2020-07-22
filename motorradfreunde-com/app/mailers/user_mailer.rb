class UserMailer < ActionMailer::Base
  default from: "\"Motorradfreunde.com\" <info@motorradfreunde.com>"

  def timeline_events_since_last_sign_in(user)
    @user = user
    @user.touch :timeline_events_sent_at
    mail to: "#{@user.name} <#{@user.email}>", subject: "Neues auf deiner Pinnwand bei motorradfreunde.com"
  end

  def new_message(message)
    @message = message
    user     = message.received_messageable
    return unless user
    mail to: "#{user.name} <#{user.email}>", subject: "Neue Nachricht erhalten auf motorradfreunde.com"
  end

  def notification_mail(notification)
    if !notification or !notification.user.present? or !notification.subject.present? or !notification.actor.present?
      return
    end
    @notification = notification
    @user = @notification.user
    @objects = {
      actor:       @notification.actor.to_s,
      commentable: @notification.commentable.to_s,
      subject:     @notification.subject.to_s,
      user:        @notification.user.to_s,
      link:        "https://www.motorradfreunde.com/account/notifications/#{notification.id}"
    }
    mail to: "#{@user.name} <#{@user.email}>", subject: I18n.t("notifications.#{@notification.notification_type}.subject", @objects)
  end

  def newsletter(user, content_objects)
    @user = user
    @user.touch :newsletter_sent_at
    @content_objects = content_objects
    mail to: "#{@user.name} <#{@user.email}>", subject: "Neues bei Motorradfreunde.com "
  end

end
