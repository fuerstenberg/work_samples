# https://github.com/stevenosloan/slack-notifier
class SlackNotificationService

  delegate :url_helpers, to: 'Rails.application.routes'

  def initialize(message)
    return if Rails.env.test?
    notifier = Slack::Notifier.new "https://hooks.slack.com/services/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" do
      defaults channel: "#notifications",
               username: "Werner"
    end
    notifier.ping Slack::Notifier::Util::LinkFormatter.format(message + " (#{Rails.env})")
  end

  def self.send(message)
    new message
  end

end
