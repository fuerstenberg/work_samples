class Image

  include Mongoid::Document
  include Mongoid::Timestamps

  include ActiveModel::Validations

  include Concerns::HasManyActivities

  embedded_in :imageable, polymorphic: true
  belongs_to :user

  field :avatar,             type: Boolean, default: false
  field :cover,              type: Boolean, default: false
  field :position,           type: Integer
  # TODO: field :copyright,     type: String, default: ""
  # TODO: field :file_hash,     type: String, default: ""
  # TODO: field :title,         type: String, default: ""
  # field :user_id,            type: BSON::ObjectId

  delegate :reset_images_count, to: :imageable, allow_nil: true
  delegate :size,               to: :file
  delegate :url,                to: :file

  mount_uploader :file, ImageUploader

  validates :file,     presence: { if: ->(image) { image.file_url.blank? } }, file_size: { minimum: 25.kilobytes.to_i, maximum: 10.megabyte.to_i }, on: :create
  validates :file_url, presence: { if: ->(image) { image.file.blank? } }, on: :create

  after_create  :reset_images_count
  after_destroy :reset_images_count

  def self.cover
    User.where('images.cover' => true).map(&:images).flatten.select(&:cover?).shuffle.first.file.url(:limit_3000_3000)
  rescue
    nil
  end

  def self.sort(params, current_user)
    params[:image].each_with_index do |id, index|
      if current_user.admin?
        Photo.update_all(['position=?', index+1], ['id=?', id])
      else
        Photo.update_all(['position=?', index+1], ['id=? AND user_id = ?', id, current_user.id])
      end
    end
  end

  def is_uploadable_by?(current_user)
    return false unless current_user
    has_permission = false
    has_permission = true if !self.imageable.is_a?(User) and self.imageable.respond_to?(:user) and self.imageable.user == current_user
    has_permission = true if self.imageable.is_a?(User) and self.imageable == current_user
    has_permission = true if self.imageable.is_a?(Poi)
    has_permission = true if current_user.admin?
    has_permission
  end

  def is_deletable_by?(current_user)
    return false unless current_user
    has_permission = false
    has_permission = true if self.imageable.is_a?(User) and self.imageable == current_user
    has_permission = true if self.imageable.respond_to?(:user) and self.imageable.user == current_user
    has_permission = true if self.user == current_user
    has_permission = true if current_user.admin?
    has_permission
  end

  def set_as_avatar
    self.imageable.images.each do |image|
      image.set avatar: false
    end
    set avatar: true
  end

end
