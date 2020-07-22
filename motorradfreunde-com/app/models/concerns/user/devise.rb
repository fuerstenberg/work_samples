module Concerns::User::Devise

  extend ActiveSupport::Concern

  included do
    # Include default devise modules. Others available are:
    # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :encryptable, :lockable, :omniauthable, omniauth_providers: [:facebook]

    field :authentication_token,         type: String
    field :confirmation_sent_at,         type: DateTime
    field :confirmation_token,           type: String
    field :confirmed_at,                 type: DateTime
    field :current_sign_in_at,           type: DateTime
    field :current_sign_in_ip,           type: String
    field :email,                        type: String
    field :encrypted_password,           type: String
    field :failed_attempts,              type: Integer
    field :last_sign_in_at,              type: DateTime
    field :last_sign_in_ip,              type: String
    field :locked_at,                    type: DateTime
    field :old_crypted_password,         type: String
    field :old_password_salt,            type: String
    field :password_salt,                type: String
    field :remember_created_at,          type: DateTime
    field :reset_password_sent_at,       type: DateTime
    field :reset_password_token,         type: String
    field :sign_in_count,                type: Integer
    field :unconfirmed_email,            type: String
    field :unlock_token,                 type: String
  end

  module ClassMethods

    def devise_attributes
      [
        :email,
        :password,
        :password_confirmation,
      ]
    end

  end

end
