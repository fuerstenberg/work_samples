# encoding: utf-8

class VideoUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  include CarrierWave::RMagick
  # include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  # storage :grid_fs
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    content = model._parent
    File.join([
      "uploads",
      "customers",
      "#{content.customer.id}",
      "#{content.class.to_s.underscore.pluralize}",
      "#{content.id}",
      "videos",
      "#{model.id}"
    ])
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    # ['application/x-shockwave-flash', 'application/x-shockwave-flash', 'application/flv', 'video/x-flv', 'video/mp4', 'video/x-m4v']
    %w(mov mp4)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  def filename
    "original.#{model.file.file.extension}" if original_filename
  end

end
