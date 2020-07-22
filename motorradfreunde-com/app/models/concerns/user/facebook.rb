module Concerns::User::Facebook

  extend ActiveSupport::Concern

  included do
    field :facebook_link,    type: String
    field :oauth_expires_at, type: DateTime
    field :oauth_token,      type: String
    field :provider,         type: String
    field :uid,              type: String

    after_create :facebook_download_avatar, if: :facebooker?
    after_create :facebook_update_friends,  if: :facebooker?
    # after_create :send_facebook_feed_message_on_user_create_to_users, if: :facebooker?

    scope :facebooker, -> { where("uid IS NOT NULL AND provider = 'facebook'") }
    scope :with_valid_facebook_token, -> { where("oauth_expires_at > ?", Time.now) }
  end


  module ClassMethods

    def from_omniauth(auth)
      logger = Logger.new "log/facebook.log"
      logger.info auth

      if auth.info and auth.info.email.blank?
        user = User.where(provider: auth.provider, uid: auth.uid).first_or_initialize
      else
        user = User.where(email: auth.info.email, provider: nil).first || User.where(provider: auth.provider, uid: auth.uid).first_or_initialize
      end

      if user.new_record?
        user.terms_of_service = true
        user.password         = user.password_confirmation = Devise.friendly_token[0,20]
      end

      user.provider         = auth.provider
      user.uid              = auth.uid
      user.email            = auth.info.email
      user.name             = auth.info.name
      user.oauth_token      = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.facebook_link    = auth.extra.raw_info.link

      begin
        if auth.extra.raw_info.location and auth.extra.raw_info.location.id
          result = user.facebook_graph.get_object(auth.extra.raw_info.location.id)
          user.latitude  = result["location"]["latitude"]
          user.longitude = result["location"]["longitude"]
        end
      rescue => e
        logger.info e
      end

      user.save
      user
    end

  end


  def facebook_graph
    Koala::Facebook::API.new self.oauth_token
  end

  def facebook_permissions(user = 'me')
    self.facebook_graph.get_connections(user, 'permissions').inject([]) do |result, permission|
      if permission["status"] == "granted"
        result << permission["permission"]
      end
      result
    end
  rescue
    []
  end

  def has_facebook_permission?(permission, user = 'me')
    self.facebook_permissions(user).include? permission.to_s
  end

  def facebooker?
    provider == 'facebook' && uid.present? ? true : false
  end

  def facebook_download_avatar
    User::FacebookAvatarDownloadWorker.perform_async self.id.to_s
  end

  def facebook_update_friends
    # if friends = facebook_graph.get_connections("me", "friends")
    #   friends.each do |friend|
    #     if friend = self.class.where(uid: friend['id']).first
    #       friend.follows self
    #       self.follows friend
    #     end
    #   end
    # end
  end

  # # nur an meine Motorradfreunde senden, dass ich bei Motorradfreunde angemeldet bin
  # # lieber keinen FB Spam erzeugen
  # def send_facebook_feed_message_on_user_create_to_users
  #   users = []
  #   users << self.followers.where("users.id != ?", self.id).with_valid_facebook_token.to_a
  #   users << self.class.where("users.id != ?", self.id).with_valid_facebook_token.near_by(self, 30).to_a if self.geocoded?
  #   users.flatten.uniq[0,30].each do |user|
  #     user.delay(priority: 30).send_single_facebook_feed_messsage_on_user_create_from(self)
  #   end
  # end
  # handle_asynchronously :send_facebook_feed_message_on_user_create_to_users, priority: 30 #, run_at: Proc.new { 10.minutes.from_now }

  # def send_single_facebook_feed_messsage_on_user_create_from(user)
  #   return false unless self.has_facebook_permission?(:publish_actions)
  #   return false unless user.has_facebook_permission?(:publish_actions)
  #   self.facebook_graph.put_connections("me", "feed", {
  #     caption:     (user.postal_code_and_city_and_state_and_country.present? ? user.postal_code_and_city_and_state_and_country : nil),
  #     description: I18n.t("facebook.feed.user.create.description"),
  #     link:        I18n.t("facebook.feed.user.create.link", id: user.id),
  #     message:     I18n.t("facebook.feed.user.create.message"),
  #     name:        user.to_s,
  #     picture:     (user.avatar_image.present? ? I18n.t("facebook.feed.user.create.picture", url: user.avatar_image.url(:square)) : nil),
  #     actions: {
  #       name: I18n.t("facebook.feed.user.create.actions.name"),
  #       link: I18n.t("facebook.feed.user.create.actions.link")
  #     }.to_json,
  #     privacy: {
  #       value: 'SELF'
  #       # value: 'CUSTOM',
  #       # allow: users.join(",")
  #     }.to_json
  #   })
  # end

end
