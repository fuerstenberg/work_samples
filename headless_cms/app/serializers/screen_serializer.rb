class ScreenSerializer < BaseSerializer

  attributes :id, :customerId, :name

  has_one :address

end
