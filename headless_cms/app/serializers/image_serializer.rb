class ImageSerializer < BaseSerializer

  attributes :content_type, :copyright, :files, :file_hash, :title

  def content_type
    self.object.file.content_type
  end

  def files
    ( [:original] + self.object.file.versions.keys ).inject({}) do |files, version|
      if version == :original
        files[version] = self.object.file.url
      else
        files[version] = self.object.file.url(version)
      end
      files
    end
  end

end
