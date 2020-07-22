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
    role :god,    GodRole,    lambda { |user| user&.god? }
    role :admin,  AdminRole,  lambda { |user| user&.admin? }
    role :owner,  OwnerRole,  lambda { |user| user&.owner_of?  customer: Current.customer }
    role :editor, EditorRole, lambda { |user| user&.editor_of? customer: Current.customer }
    role :guest,  GuestRole,  lambda { |user| user.roles.empty? }
  end
end
