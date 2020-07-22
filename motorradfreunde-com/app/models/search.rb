class Search

  ALL_SEARCHABLE_MODELS = [
    Bike,
    Event,
    Poi,
    Route,
    Video,
    User,
  ]

  def self.index
    ALL_SEARCHABLE_MODELS.each &:index_keywords!
  end

  def self.full_text_search(query, limit = 20)
    if query.present?
      ALL_SEARCHABLE_MODELS.inject({}) do |result, klass|
        result[klass] = klass.full_text_search(query).limit(limit)
        result
      end
    else
      {}
    end
  end

end
