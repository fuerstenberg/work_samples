module Concerns::Content::Asset

  extend ActiveSupport::Concern

  included do
    # scope :assets, -> { self.content_type.content_fields.where(:_type.in => [ContentField::Image]) }
  end

  def all_assets
    assets = self.content_type.content_fields.assets.inject([]) do |assets, content_field|
      assets << self.send(content_field.field_id)
      assets
    end
    assets.flatten.compact
  end

end
