module Concerns::Content::Search

  extend ActiveSupport::Concern

  included do
    # mongoid_search
    # instead of using default way to generate keywords, i used this, to create a search index,
    # because every content object is different and depents on a content_type object
    field :_keywords, type: Array

    index({ _keywords: 1 }, { background: true })

    after_save :update_search_index
  end

  module ClassMethods

    def update_search_index
      all.each &:update_search_index
    end

  end

  def update_search_index
    fields = [:id] + (allowed_field_ids_without_nested_fields || [])
    set _keywords: Mongoid::Search::Util.keywords(self, fields).flatten.reject{|k| k.nil? || k.empty?}.uniq.sort
  end

end
