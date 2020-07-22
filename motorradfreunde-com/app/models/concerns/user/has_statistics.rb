module Concerns::User::HasStatistics

  extend ActiveSupport::Concern

  module ClassMethods
    def statistics_for_users_per_day
      results = []
      90.downto(0) do |i|
        range = ((Date.today-i.days).beginning_of_day..(Date.today-i.days).end_of_day)
        results << { day: I18n.l(range.first.to_date, format: :longer), users: User.where(created_at: range).count }
      end
      results
    rescue
      []
    end

    def statistics_for_users_per_week
      results = []
      52.downto(0) do |i|
        range = ((Date.today-i.week).beginning_of_week..(Date.today-i.week).end_of_week)
        results << { week: "#{I18n.l(range.first, format: :shorter)} - #{I18n.l(range.last, format: :long)}", users: User.where(created_at: range).count }
      end
      results
    rescue
      []
    end

    def statistics_for_users_per_month
      results = []
      48.downto(0) do |i|
        range = ((Date.today-i.month).beginning_of_month..(Date.today-i.month).end_of_month)
        results << { month: I18n.l(range.first, format: :month_and_year), users: User.where(created_at: range).count }
      end
      results
    rescue
      []
    end

    def gender_statistics
      [
        {label: 'male',    value: User.tagged_with("male",   on: :genders).count},
        {label: 'female',  value: User.tagged_with("female", on: :genders).count},
        {label: 'nothing', value: User.tagged_with(["male", "female"], on: :genders, exclude: true).count}
      ]
    end
  end

end
