class ConversationMembership

  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user
  embedded_in :conversation, inverse_of: :memberships

  field :admin,   type: Boolean, default: false
  field :read_at, type: Time #,    default: ->{ Time.now }

  validates :user, presence: true, uniqueness: true

  def read!
    set read_at: Time.current
  end

  def set_as_admin!
    set admin: true
  end

end
