class SlackNotificationWorker
  include Sidekiq::Worker

  def perform(message)
    SlackNotificationService.send message
  end
end
