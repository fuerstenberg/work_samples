class ContentField::Address < ContentField::Base

  include Concerns::ContentField::Nested

  def polymorphic_association_name
    :addressable
  end

end
