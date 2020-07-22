module Concerns::HasMetaMethods

  extend ActiveSupport::Concern

  included do
  end


  def to_title
    return self.title if self.respond_to?(:title)
    return self.name  if self.respond_to?(:name)
    return self.to_s  if self.respond_to?(:to_s)
  end

  def to_description
    return self.description if self.respond_to?(:description)
  end

  def to_keywords
    []
  end

end
