# encoding: utf-8

class LogoUploader < CarrierWave::Uploader::Base

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
    File.join([
      "uploads",
      "#{model.class.to_s.underscore.pluralize}",
      "#{model.id}",
      "logo"
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

  # process resize_to_fill: [500, 500]
  process convert: 'png'

  # Create different versions of your uploaded files:
  version :xs do
    process resize_to_fit: [100, 100]

    def full_filename(for_file = model.logo.file)
      "xs.png"
    end
  end

  version :sm do
    process resize_to_fit: [400, 400]

    def full_filename(for_file = model.logo.file)
      "sm.png"
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
    "original.#{model.logo.file.extension}" if original_filename
  end

end
