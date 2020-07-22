class User

  include Mongoid::Document
  include Mongoid::Timestamps

  include Concerns::User::Devise
  include Concerns::User::Roles

  field :language,   type: String,  default: "de"
  field :name,       type: String,  default: ""

  validates :name, presence: true

  def to_s
    name
  end

end
