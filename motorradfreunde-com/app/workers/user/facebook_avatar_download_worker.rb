class User::FacebookAvatarDownloadWorker
  include Sidekiq::Worker

  def perform(user_id)
    User::FacebookAvatarDownloadService.process user_id: user_id
  end
end
