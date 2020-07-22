module Concerns::Content::Video

  extend ActiveSupport::Concern

  included do
  end

  def all_videos
    videos = self.content_type.content_fields.where(_type: ContentField::Video).inject([]) do |videos, content_field|
      videos << self.send(content_field.field_id)
      videos
    end
    videos.flatten.compact
  end

  def build_video_content_fields
    return unless self.content_type
    self.content_type.content_fields.where(_type: ContentField::Video).each do |content_field|
      if content_field.has_many?
        self.send(content_field.field_id).build
      elsif content_field.has_one? and self.send(content_field.field_id).blank?
        self.send("build_#{content_field.field_id}")
      end
    end
  end

  def find_video(id)
    self.all_videos.detect do |video|
      video.id.to_s == id
    end
  end

  # TODO: TESTS
  def nested_reject_if_for_video(attributes)
    attributes['file'].blank? and attributes['remote_file_url'].blank? and not attributes['id']
  end

  # TODO: TESTS
  def nested_reject_if_for_videos(attributes)
    attributes['file'].blank? and attributes['remote_file_url'].blank? and not attributes['_destroy']
  end

end
