class ContentField::Document < ContentField::Base

  include Concerns::ContentField::Nested

  def polymorphic_association_name
    :documentable
  end

end
