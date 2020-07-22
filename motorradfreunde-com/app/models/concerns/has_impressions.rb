module Concerns::HasImpressions

  extend ActiveSupport::Concern

  included do
    field :impressions_count, type: Fixnum, default: 0

    index({ impressions_count: -1 }, { name: 'impressions_count_index_desc' })
  end

  module ClassMethods

    def count_impression(id)
      find_by(slug: id).count_impression
    rescue
      find(id).count_impression
    end

  end

  def count_impression
    if impressions_count.nil? or impressions_count == 0
      set impressions_count: 1
    else
      inc impressions_count: 1
    end
  end

end
