class ContentSerializer < BaseSerializer

  attributes :assets, :content_type

  def assets
    self.object.all_assets.map do |asset|
      asset.url_hash
    end
  end

  def attributes(resource, extra_meta = {})
    data = super
    data['_checksum'] = object._checksum
    object.content_type.content_fields.each do |content_field|
      if content_field.is_a?(ContentField::Image)
        if content_field.has_many?
          if resource = object.send(content_field.field_id)
            data[content_field.field_id] = ActiveModel::Serializer::CollectionSerializer.new resource
          end
        else
          if resource = object.send(content_field.field_id)
            data[content_field.field_id] = ImageSerializer.new( resource )
          end
        end
      elsif content_field.is_a?(ContentField::Video)
        if content_field.has_many?
          if resource = object.send(content_field.field_id)
            data[content_field.field_id] = ActiveModel::Serializer::CollectionSerializer.new resource
          end
        else
          if resource = object.send(content_field.field_id)
            data[content_field.field_id] = VideoSerializer.new( resource )
          end
        end
      elsif content_field.is_a?(ContentField::Document)
        if content_field.has_many?
          if resource = object.send(content_field.field_id)
            data[content_field.field_id] = ActiveModel::Serializer::CollectionSerializer.new resource
          end
        else
          if resource = object.send(content_field.field_id)
            data[content_field.field_id] = DocumentSerializer.new( resource )
          end
        end
      elsif content_field.is_a?(ContentField::Address)
        if content_field.has_many?
          if resource = object.send(content_field.field_id)
            data[content_field.field_id] = ActiveModel::Serializer::CollectionSerializer.new resource
          end
        else
          if resource = object.send(content_field.field_id)
            data[content_field.field_id] = AddressSerializer.new( resource )
          end
        end
      else
        data[content_field.field_id] = object[content_field.field_id]
      end
    end
    data
  end

  def content_type
    if object.respond_to?(:content_type)
      object.content_type.type
    else
      object.class.to_s
    end
  end

end
