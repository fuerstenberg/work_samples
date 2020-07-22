# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  # storage :grid_fs
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    imageable = model._parent
    File.join([
      "uploads",
      "images",
      "#{imageable.class.to_s.underscore.pluralize}",
      "#{imageable.id}",
      "images",
      "#{model.id}"
    ])
  end

  def default_url(*args)
    "/assets/signet_white_with_red_bg.svg"
  end

  process convert: 'png'

  version :limit_3000_3000 do
    process convert: 'jpg'
    process resize_to_limit: [3000, 3000]
    process quality: 80

    def full_filename(for_file = model.file.file)
      "limit_3000_3000.jpg"
    end
  end

  version :limit_1000_1000 do
    process convert: 'jpg'
    process resize_to_limit: [1000, 1000]
    process quality: 80

    def full_filename(for_file = model.file.file)
      "limit_1000_1000.jpg"
    end
  end

  version :limit_800_800 do
    process convert: 'jpg'
    process resize_to_limit: [800, 800]
    process quality: 80

    def full_filename(for_file = model.file.file)
      "limit_800_800.jpg"
    end
  end

  # resize up or down to a square
  version :fill_600_600, from_version: :limit_1000_1000 do
    process convert: 'jpg'
    process resize_to_fill: [600, 600]
    process quality: 60

    def full_filename(for_file = model.file.file)
      "fill_600_600.jpg"
    end
  end

  version :fill_300_300, from_version: :fill_600_600 do
    process convert: 'jpg'
    process resize_to_fill: [300, 300]
    process quality: 60

    def full_filename(for_file = model.file.file)
      "fill_300_300.jpg"
    end
  end

  version :fill_200_200, from_version: :fill_600_600 do
    process convert: 'jpg'
    process resize_to_fill: [200, 200]
    process quality: 60

    def full_filename(for_file = model.file.file)
      "fill_200_200.jpg"
    end
  end

  version :fill_120_120, from_version: :fill_600_600 do
    process convert: 'jpg'
    process resize_to_fill: [120, 120]
    process quality: 60

    def full_filename(for_file = model.file.file)
      "fill_120_120.jpg"
    end
  end

  version :fill_100_100, from_version: :fill_600_600 do
    process convert: 'jpg'
    process resize_to_fill: [100, 100]
    process quality: 60

    def full_filename(for_file = model.file.file)
      "fill_100_100.jpg"
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

  def quality(percentage)
    manipulate! do |img|
      img.quality(percentage.to_s)
      img = yield(img) if block_given?
      img
    end
  end
end
