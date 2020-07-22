class Conversation

  include Mongoid::Document
  include Mongoid::Search
  include Mongoid::Timestamps

  embeds_many :memberships, class_name: 'ConversationMembership'

  has_many :messages, order: :created_at.desc

  field :name,              type: String
  field :description,       type: String
  field :recent_message_at, type: DateTime

  validates :memberships, length: { minimum: 2 }

  scope :by_user, ->(user){ where('memberships.user_id' => (user.is_a?(User) ? user.id : user.to_s)) }

  def self.find_or_initialize_by_members(*members)
    # MongoDB-Query { "memberships.user_id": { $all: [ObjectId("58c12aeee1da34315500bd0a"), ObjectId("58c12af1e1da34315500e5b1")] } }
    # find_or_initialize_by 'memberships.user_id' => { '$all' => members.map{ |member| member.is_a?(User) ? member.id : member.to_s } }

    find_by 'memberships.user_id' => { '$all' => members.map{ |member| member.is_a?(User) ? member.id : member.to_s } }
  rescue Mongoid::Errors::DocumentNotFound
    new memberships: members.map{ |member| member.is_a?(User) ? { user_id: member.id } : { user_id: member.to_s } }
  end

  def self.find_or_create_by_members(*members)
    conversation = find_or_initialize_by_members *members
    conversation.save
    conversation
  end

  def add_admin(user)
    find_membership_by(user).set_as_admin!
  end

  def add_membership_by(user)
    memberships.find_or_create_by user: user
  end

  def find_membership_by(user)
    memberships.find_by user: user
  end

  def has_admin?(user)
    find_membership_by(user).admin? rescue false
  end

  def has_member?(user)
    find_membership_by user rescue false
  end

  def members
    memberships.map &:user
  end
  alias :users :members

  # def members=(*members)
  #   memberships = members.map do |member|
  #     ConversationMembership.new user: member
  #   end
  # end
  # alias :users= :members=

  def members_without(user)
    (members - [user]).compact
  end

  # def open_by(user)
  #   set opened: true
  # end
  # alias :mark_as_read :open
  # alias :read         :open

  def read_by!(user)
    find_membership_by(user).read!
  end

  def read_by?(user)
    membership = find_membership_by(user)
    membership and (!recent_message_at.present? or (membership.read_at and recent_message_at < membership.read_at))
  end

  def remove_admin(user)
  end

  def remove_member(user)
  end

  def set_recent_message_time!
    set recent_message_at: messages.max_by(&:created_at)&.created_at
  end

end
