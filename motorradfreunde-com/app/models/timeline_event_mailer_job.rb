class TimelineEventMailerJob < Struct.new(:user_id)

  def perform
    if user = User.find(user_id)
      UserMailer.timeline_events_since_last_sign_in(user).deliver
    end
  end

end