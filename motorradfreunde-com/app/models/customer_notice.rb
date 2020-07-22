class CustomerNotice

  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :customer

  field :body, type: String

  belongs_to :customer

end
