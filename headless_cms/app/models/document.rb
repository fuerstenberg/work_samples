require 'digest/md5'

class Document

  include Mongoid::Document
  include Mongoid::Timestamps

  embedded_in :documentable, polymorphic: true

  field :copyright,     type: String, default: ""
  field :file_hash,     type: String, default: ""
  field :title,         type: String, default: ""

  mount_uploader :file, DocumentUploader

  # validates :field_id, presence: true
  validates :file,     presence: true, if: ->(document) { document.file_url.blank? }
  validates :file_url, presence: true, if: ->(document) { document.file.blank? }
  validates :file_hash, uniqueness: { scope: [:title] }, allow_blank: true

  def file=(file)
    if file and file.respond_to?(:tempfile) and file.tempfile
      self.file_hash = Digest::MD5.hexdigest File.read(file.tempfile)
    elsif file.is_a?(File)
      self.file_hash = Digest::MD5.hexdigest file.read
    end
    super file
  end

  def url_hash
    return unless self.file
    urls = {}
    urls[:original] = self.file.url
    self.file.versions.each do |key, file|
      urls[key] = file.url
    end
    urls
  end

end
