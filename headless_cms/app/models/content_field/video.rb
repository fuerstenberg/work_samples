class ContentField::Video < ContentField::Base

  include Concerns::ContentField::Nested

  def polymorphic_association_name
    :watchable
  end

end
