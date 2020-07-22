module TagsHelper

  # include ActsAsTaggableOn::TagsHelper

  def translate_tags(tags)
    tags.map{|tag| I18n.t("tags.#{tag}")}
  end

  def join_tags(tags)
    translate_tags(tags).join(', ')
  end

  def tags_to_sentence(tags)
    # TODO: translate_tags(tags).to_sentence
    tags
  end

end
