module Concerns::Content::Releases

  extend ActiveSupport::Concern

  included do
    delegate :auto_publish?, to: :content_type, allow_nil: true

    embeds_many :releases

    accepts_nested_attributes_for :releases, allow_destroy: true

    scope :released_for_screen, ->(screen){ where('releases.screen_id' => (screen.is_a?(Screen) ? screen.id : screen)) }

    before_create :release_for_all_screens, if: :auto_publish?
  end

  def has_released_for_screen?(screen_id)
    if screen_id.is_a?(Screen)
      screen_id = screen_id.id
    end
    self.releases.where(screen_id: screen_id).exists?
  end

  def has_released_to_any_screen?
    self.releases.present?
  end

  def release_for_all_screens
    customer.screens.each do |screen|
      releases.find_or_initialize_by screen: screen
    end
  end

  def destroy_release_for_screen(screen)
    releases.where(screen_id: screen.id).destroy_all
  end

  # def release_on_screen_ids
  #   self.releases.map &:screen_id
  # end
  #
  # def release_on_screen_ids=(screen_ids)
  #   delete_screen_ids = self.release_on_screen_ids - screen_ids
  #   self.releases.where(:screen_id.in => delete_screen_ids).delete_all
  #   screen_ids.each do |screen_id|
  #     release = self.releases.find_or_initialize_by screen_id: screen_id
  #     release.save
  #   end
  #   self
  # end

  # def release_on_screens=(screens)
  #   self.release_on_screen_ids screens.to_a.flatten.map(&:id)
  # end
  #
  # def publish_on_all_screens(start_at = Time.now, end_at = nil)
  #   self.publish_on_screens self.customer.screen_ids, screen_ids, start_at, end_at
  # end
  #
  # # accepts screen, screens, id, ids
  # def publish_on_screens(screen_ids, start_at = Time.now, end_at = nil)
  #   screen_ids = screen_ids.to_a.flatten.map do |screen_id|
  #     if screen_id.is_a?(Screen)
  #       screen_id.id.to_s
  #     else
  #       screen_id.to_s
  #     end
  #   end
  #   existing_screen_ids = self.releases.map(:screen_id)
  #   screen_ids.each do |screen_id|
  #     release = self.releases.find_or_initialize_by screen_id: screen_id
  #     release.start_at = start_at
  #     release.end_at = end_at
  #   end
  #   self
  # end

end
