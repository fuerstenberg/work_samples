class RawDataSet

  include Mongoid::Document
  include Mongoid::Timestamps

  include Concerns::Customer::Database

  belongs_to :content

  field :xml, type: String

end
