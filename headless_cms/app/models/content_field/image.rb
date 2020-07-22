class ContentField::Image < ContentField::Base

  include Concerns::ContentField::Nested

  def polymorphic_association_name
    :imageable
  end

end
