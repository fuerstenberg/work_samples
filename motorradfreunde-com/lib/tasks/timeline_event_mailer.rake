namespace :timeline_event_mailer do
  desc "Generates delayed jobs to send timeline events via mail to user"
  task :generate => :environment do

    User.where("current_sign_in_at IS NOT NULL AND current_sign_in_at < ?", Time.now - 7.days).where("timeline_events_sent_at IS NOT NULL AND timeline_events_sent_at < ?", Time.now - 7.days).all.each do |user|
      Delayed::Job.enqueue TimelineEventMailerJob.new(user.id)
    end

  end
end