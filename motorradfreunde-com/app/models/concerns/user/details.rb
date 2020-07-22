module Concerns::User::Details

  extend ActiveSupport::Concern

  included do
    field :date_of_birth,        type: Date
    field :description,          type: String
    field :distance_per_year,    type: Integer
    field :distance_total,       type: Integer
    field :driving_description,  type: String
    field :favorite_vendor,      type: String
    field :favourite_areas,      type: String
    field :favourite_experience, type: String
    field :licence_date,         type: Date

    field :favorite_clothing,                   type: Array, default: []
    field :favorite_drive_type,                 type: Array, default: []
    field :favorite_driving_style,              type: Array, default: []
    field :interested_in_gender,                type: Array, default: []
    field :status_as_biker,                     type: Array, default: []
    field :status_of_social_behavior,           type: Array, default: []

    # TODO: acts_as_taggable_on :backseat, :clothing, :drive_types, :driving_styles, :genders, :interested_in_gender, :relationship, :rides, :rides_with_other, :owns_motorcycle
    enumerize :favorite_clothing,                   multiple: true, in: %w(textile leather),                                          predicates: { prefix: true }
    enumerize :favorite_drive_type,                 multiple: true, in: %w(cardan chain belt),                                        predicates: { prefix: true }
    enumerize :favorite_driving_style,              multiple: true, in: %w(cruise offroad race tour fast speeder),                    predicates: { prefix: true }
    enumerize :favorite_engine_amount_of_cylinders,                 in: 1..12
    enumerize :gender,                                              in: %w(male female),                                              predicates: { prefix: true }
    enumerize :has_own_motorcycle,                                  in: %w(yes no),                                                   predicates: { prefix: true }
    enumerize :interested_in_gender,                multiple: true, in: %w(male female),                                              predicates: { prefix: true }
    enumerize :status_as_biker,                     multiple: true, in: %w(driver passenger),                                         predicates: { prefix: true }
    enumerize :status_of_social_behavior,           multiple: true, in: %w(alone multiple),                                           predicates: { prefix: true }
    enumerize :status_for_backseat,                                 in: %w(not_looking_for_someone looking_for_someone looking_for_a_backseat busy), predicates: { prefix: true }
    enumerize :status_for_relationship,                             in: %w(single complicated divorced widower relationship married), predicates: { prefix: true }
  end

  module ClassMethods

    def detail_attributes
      [
        :date_of_birth,
        :description,
        :distance_per_year,
        :distance_total,
        :driving_description,
        :favorite_engine_amount_of_cylinders,
        :favorite_vendor,
        :favourite_areas,
        :favourite_experience,
        :gender,
        :has_own_motorcycle,
        :licence_date,
        :status_for_backseat,
        :status_for_relationship,
        { favorite_clothing: [] },
        { favorite_drive_type: [] },
        { favorite_driving_style: [] },
        { interested_in_gender: [] },
        { status_as_biker: [] },
        { status_of_social_behavior: [] },
      ]
    end
  end

  def age
    if self.date_of_birth
      age = Date.today.year - self.date_of_birth.year
      age = age - 1 if Date.today.month < self.date_of_birth.month
      age = age - 1 if Date.today.month == self.date_of_birth.month and Date.today.day < self.date_of_birth.day

      return age
    else
      nil
    end
  end

  def gender?
    gender.present?
  end

  def licence_date=(value)
    self[:licence_date] = Date.parse("#{value}-01-01")
  end

  def licence_date
    self[:licence_date].year rescue nil
  end

end
