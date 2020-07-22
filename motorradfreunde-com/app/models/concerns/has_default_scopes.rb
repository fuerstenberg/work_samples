module Concerns::HasDefaultScopes

  extend ActiveSupport::Concern

  included do
    scope :by_user, -> user{ where(user_id: (user.is_a?(User) ? user.id : user.to_s)) }
    scope :recent, -> { order(created_at: :desc) }

    index({ created_at:  1 }, { name: 'created_at_asc' })
    index({ created_at: -1 }, { name: 'created_at_desc' })
  end

end
