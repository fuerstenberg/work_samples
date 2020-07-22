module Concerns::Screen::ContentList

  extend ActiveSupport::Concern

  included do
    belongs_to :content_list, optional: true
  end

end
