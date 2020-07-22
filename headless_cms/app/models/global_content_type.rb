class GlobalContentType

  include Mongoid::Document
  include Mongoid::Timestamps
  include Concerns::Shared::ContentType

  def build_content_type_for_customer(customer = Current.customer)
    content_type = ContentType.new attributes.except('id', '_id', 'content_fields')
    content_type.customer = customer

    embedded_relations.each_pair do |name, meta|
      without_autobuild do
        unless name == 'content_fields'
          content_type.__send__ name + '=', self.__send__(name).__deep_copy__
        end
      end
    end
    content_type
  end
end
