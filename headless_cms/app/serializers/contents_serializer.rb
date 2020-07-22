class ContentsSerializer < BaseSerializer

  attributes :_checksum, :content_type, :foreign_id

  def content_type
    if object.respond_to?(:content_type)
      object.content_type.type
    else
      object.class.to_s
    end
  end

end
