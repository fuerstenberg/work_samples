module Concerns::HasManyActivities

  extend ActiveSupport::Concern
  include PublicActivity::Model

  included do
    has_many :activities, as: :trackable, class_name: 'PublicActivity::Activity', dependent: :destroy

    after_create  :create_activity
    after_destroy :destroy_activity
    after_update  :update_activity
  end

  def create_activity
    ActivityBaseService.process object: self, on: :create
  end

  def destroy_activity
    ActivityBaseService.process object: self, on: :destroy
  end

  def update_activity
    ActivityBaseService.process object: self, on: :update
  end

end
