class ContentNode

  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Tree

  include Concerns::Customer::Database

  field :name, type: String

  validates :name, presence: true
  validates_associated :parent, :children

  private

  def must_be_root
    errors.add(:parent, 'must be empty') unless root?
  end

end
