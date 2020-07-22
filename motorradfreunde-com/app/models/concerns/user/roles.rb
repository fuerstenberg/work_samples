module Concerns::User::Roles

  extend ActiveSupport::Concern

  included do
    field :admin,     type: Boolean, default: false
    field :moderator, type: Boolean, default: false
  end

  def member?
    true
  end

end
