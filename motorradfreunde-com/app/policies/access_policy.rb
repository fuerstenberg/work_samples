class AccessPolicy
  include AccessGranted::Policy

  def configure
    # https://github.com/chaps-io/access-granted/blob/master/README.md
    #
    # Roles inherit from less important roles, so:
    # - :admin has permissions defined in :member, :guest and himself
    # - :member has permissions from :guest and himself
    # - :guest has only its own permissions since it's the first role.
    #
    # The most important role should be at the top.
    # In this case an administrator.
    role :admin,     AdminRole,     lambda { |user| user&.admin? }
    role :moderator, ModeratorRole, lambda { |user| user&.moderator? }
    role :member,    MemberRole,    lambda { |user| user&.member? }
    role :guest,     GuestRole
  end
end
