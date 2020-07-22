class CustomerSerializer < BaseSerializer

  attributes :id, :name, :screen_ids

  has_one :address

  def screen_ids
    object.screen_ids.map &:to_s
  end

end
