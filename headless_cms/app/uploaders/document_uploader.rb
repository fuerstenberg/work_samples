class DocumentUploader < CarrierWave::Uploader::Base

  include CarrierWave::RMagick
  # include CarrierWave::MiniMagick

  storage :file

  def store_dir
    content = model._parent
    File.join([
      "uploads",
      "customers",
      "#{content.customer.id}",
      "#{content.class.to_s.underscore.pluralize}",
      "#{content.id}",
      "documents",
      "#{model.id}"
    ])
  end

end
