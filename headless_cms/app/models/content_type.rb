class ContentType

  include Mongoid::Document
  include Mongoid::Timestamps
  include Concerns::Shared::ContentType

  include Concerns::Customer::Database

  belongs_to :customer

  has_many :contents

end
