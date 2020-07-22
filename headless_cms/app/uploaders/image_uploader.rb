# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base

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
      "images",
      "#{model.id}"
    ])
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  process convert: 'png'

  # Create different versions of your uploaded files:
  version :l do
    process resize_to_fit: [1280, 1280]

    def full_filename(for_file = model.file.file)
      "l.png"
    end
  end

  version :m, from_version: :l do
    process resize_to_fit: [800, 800]

    def full_filename(for_file = model.file.file)
      "m.png"
    end
  end

  version :s, from_version: :m do
    process resize_to_fit: [200, 200]

    def full_filename(for_file = model.file.file)
      "s.png"
    end
  end

  version :xs, from_version: :s do
    process resize_to_fit: [100, 100]

    def full_filename(for_file = model.file.file)
      "xs.png"
    end
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg gif png)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  def filename
    "original.#{model.file.file.extension}" if original_filename
  end

end
