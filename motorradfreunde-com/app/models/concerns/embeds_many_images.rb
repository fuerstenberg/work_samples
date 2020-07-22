module Concerns::EmbedsManyImages

  extend ActiveSupport::Concern

  included do
    embeds_many :images, as: :imageable, cascade_callbacks: true

    accepts_nested_attributes_for :images, allow_destroy: true, limit: 10, reject_if: :nested_reject_if_for_images

    scope :order_by_has_images, -> { order(has_images: :desc) }
    scope :with_images,         -> { where(:images_count.gt => 0) }

    field :images_count, type: Integer, default: 0
    field :has_images,   type: Boolean, default: false

    index({ has_images: -1 }, { name: 'has_images_index_desc' })
    index({ has_images: -1, created_at: -1 }, { name: 'has_images_created_at_index_desc' })
    index({ created_at: -1, has_images: -1 })
    index({ images_count: 1 }, { name: 'images_count_index_asc' })
    index images_count: -1, has_images: -1, created_at: -1
    index({ impressions_count: -1, has_images: -1, created_at: -1 })
  end

  def preview(format = :limit_800_800)
    (self.preview_image || self.images.first || Image.new).url format
  end
  alias avatar preview

  def preview_image
    images.detect(&:avatar?)
  end
  alias avatar_image preview_image

  private

  def nested_reject_if_for_images(attributes)
    attributes['file'].blank? and attributes['remote_file_url'].blank? and not attributes['_destroy']
  end

  def reset_images_count
    images_count = images.to_a.count
    set images_count: images_count, has_images: (images_count > 0)
  end

end
