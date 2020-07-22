class DocumentSerializer < BaseSerializer

  attributes :content_type, :copyright, :files, :file_hash, :title

  def content_type
    self.object.file.content_type
  end

  def files
    {
      original: self.object.file.url
    }
  end

end
