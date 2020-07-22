class ContentList < ContentNode

  belongs_to :customer
  has_many :screens

  validate :must_be_root

  def to_s
    name
  end

end
