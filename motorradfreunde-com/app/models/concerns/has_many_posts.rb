module Concerns::HasManyPosts
  extend ActiveSupport::Concern

  included do
    has_many :posts, as: :poster
  end
end
