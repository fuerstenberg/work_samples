# encoding: utf-8

class StaticMapUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick

  storage :file

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    addressable = model._parent
    File.join([
      "uploads",
      "static_maps",
      "#{addressable.class.to_s.underscore.pluralize}",
      "#{addressable.id}",
      "#{model.id}"
    ])
  end

  def default_url(*args)
    "/assets/signet_white_with_red_bg.svg"
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg gif png)
  end

  version :fill_600_600 do
    process convert: 'jpg'
    process resize_to_fill: [600, 600]
    process quality: 60

    def full_filename(for_file = model.file.file)
      "fill_600_600.jpg"
    end
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  def filename
    "original.#{model.static_map.file.extension}" if original_filename
  end

  def quality(percentage)
    manipulate! do |img|
      img.quality(percentage.to_s)
      img = yield(img) if block_given?
      img
    end
  end
end
