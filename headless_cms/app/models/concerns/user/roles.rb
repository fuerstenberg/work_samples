module Concerns::User::Roles

  extend ActiveSupport::Concern

  included do
    embeds_many :roles, cascade_callbacks: true

    after_create :add_editor_role_for_current_customer
  end

  def admin?
    roles.where(type: :admin).exists?
  end

  def becomes_admin!
    roles.delete_all
    becomes_role! type: :admin, customer: nil
  end

  def becomes_god!
    roles.delete_all
    becomes_role! type: :god, customer: nil
  end

  def becomes_editor_of!(customer:)
    becomes_role! type: :editor, customer: customer
  end

  def becomes_owner_of!(customer:)
    becomes_role! type: :owner, customer: customer
  end

  def customers
    if god? || admin?
      ::Customer.all
    else
      roles.map &:customer
    end
  end

  def editor?
    editor_of? customer: Current.customer
  end

  def editor_of?(customer:)
    roles.where(type: :editor, customer: customer).exists?
  end

  def god?
    roles.where(type: :god).exists?
  end

  def has_many_customers?
    customers.size > 1
  end

  def has_roles_for_all_customers
    (Customer.all.to_a - customers.to_a).empty?
  end

  def has_role_for?(customer:)
    roles.where(customer: customer).exists?
  end

  def owner?
    owner_of? customer: Current.customer
  end

  def owner_of?(customer:)
    roles.where(type: :owner, customer: customer).exists?
  end

  private

  def add_editor_role_for_current_customer
    if Current.customer
      becomes_editor_of! customer: Current.customer
    end
  end

  def becomes_role!(type:, customer:)
    role = roles.find_or_initialize_by customer: customer
    role.type = type
    role.save!
    role
  end

end
