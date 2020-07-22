module Concerns::Screen::ContentTree

  extend ActiveSupport::Concern

  included do
    belongs_to :content_tree, optional: true
  end

end
