module Concerns::Shared::Address

  extend ActiveSupport::Concern

  included do
    embeds_one :address, as: :addressable

    accepts_nested_attributes_for :address

    after_validation :geocode_address
  end

  def city
    address.try :city
  end

  def country
    address.try :country
  end

  def street
    address.try :street
  end

  def zip
    address.try :zip
  end

  private

  def geocode_address
    if self.address and self.address.valid?
      self.address.geocode
    end
  end

end
