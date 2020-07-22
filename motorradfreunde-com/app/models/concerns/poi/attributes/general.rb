module Concerns::Poi::Attributes::General

  extend ActiveSupport::Concern

  included do
    field :contact,              type: String
    field :description,          type: String
    field :email,                type: String
    field :enabled_at,           type: DateTime
    field :enabled_until,        type: DateTime
    field :fax,                  type: String
    field :import_url,           type: String
    field :mobile,               type: String
    field :name,                 type: String
    field :opening_times,        type: String
    field :phone,                type: String
    field :premium,              type: Boolean, default: false
    field :published,            type: Boolean, default: false
    field :types,                type: Array,   default: []
    field :website,              type: String

    validate :uniqueness_by_website_and_zip
  end

  module ClassMethods

    def allowed_attributes
      general_attribute_names +
      bike_builder_attribute_names +
      dealer_attribute_names +
      hotel_attribute_names +
      magazin_attribute_names +
      mountain_pass_attribute_names +
      rental_company_attribute_names +
      shop_attribute_names +
      tour_operator_attribute_names +
      bike_builder_attribute_names +
      vendor_attribute_names +
      workshop_attribute_names +
      address_attributes
    end

    def attributes_with_prefix_is
      attributes_with_prefix 'is'
    end

    def attributes_with_prefix(prefix)
      attribute_names.select do |attribute|
        attribute.starts_with? "#{prefix}_"
      end
    end

    def general_attribute_names
      [
        :contact,
        :description,
        :email,
        :enabled_at,
        :enabled_until,
        :fax,
        :import_url,
        :mobile,
        :name,
        :opening_times,
        :phone,
        :premium,
        :published,
        :types,
        :website,
      ]
    end

  end

  def uniqueness_by_website_and_zip
    if self.website.present? and self.address&.zip.present? and self.class.where(website: self.website, 'address.zip' => self.address&.zip, :id.ne => self.id).first
      errors.add :website, 'website / zip combination must be unique'
    end
  end

end
