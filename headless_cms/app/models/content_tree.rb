class ContentTree < ContentNode

  belongs_to :customer
  has_many :screens

  validate :must_be_root

end
