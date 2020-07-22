module Concerns::User::PublicActivities

  extend ActiveSupport::Concern

  included do
  end

  def public_activities
    # TODO: replace the uniq part by map-reduce-function
    PublicActivity::Activity.where(:$or => [{:user_ids.in => [id]}, {user_ids: []}]).order(updated_at: :desc).uniq{ |a| "#{a.parent_type}_#{a.parent_id}" }
  end

end
