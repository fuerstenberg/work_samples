module Concerns::Screen::Releases

  extend ActiveSupport::Concern

  included do
    # after_create :generate_content_releases
    before_destroy :destroy_content_releases
  end

  # def publish(content, start_at = Time.now, end_at = nil)
  #   self.releases.create content: content, start_at: start_at, end_at: end_at, order: self.releases.count
  # end

  private

  # before_destroy
  def destroy_content_releases
    customer.contents.each do |content|
      content.destroy_release_for_screen self
    end
  end

  # def generate_content_releases
  #   customer.contents.each do |content|
  #     self.releases.create content: content
  #   end
  # end

end
