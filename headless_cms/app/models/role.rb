class Role

  include Mongoid::Document
  include Mongoid::Timestamps

  CUSTOMER_DEPENDENT_TYPES = [:editor, :owner].freeze
  CUSTOMER_INDEPENDENT_TYPES = [:god, :admin].freeze
  TYPES = CUSTOMER_DEPENDENT_TYPES + CUSTOMER_INDEPENDENT_TYPES

  embedded_in :user
  belongs_to :customer, optional: true

  field :type, type: Symbol, default: :editor

  validates :type, presence: true, inclusion: { in: TYPES }, uniqueness: { scope: [:customer_id] }
  validates :customer, presence: { if: :customer_needed? }

  def admin?
    type == :admin
  end

  def editor?
    type == :editor
  end

  def god?
    type == :god
  end

  def owner?
    type == :owner
  end

  private

  def customer_needed?
    CUSTOMER_DEPENDENT_TYPES.include? type
  end

end
