module Concerns::User::Conversations

  extend ActiveSupport::Concern

  def conversations
    Conversation.by_user(self).order(recent_message_at: :desc)
  end

end
