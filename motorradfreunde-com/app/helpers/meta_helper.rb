module MetaHelper

  def meta(obj, additional = nil)
    meta_title obj, additional
    meta_description obj
    meta_keywords obj
  end

  def meta_title(obj, additional = nil)
    if obj.is_a?(String)
      title = [obj]
    else
      title = [obj.to_title]
    end
    title << additional if additional.present?
    title << "Seite #{params[:page]}" if params[:page]
    content_for :meta_title, title.compact.join(" - ")
  end

  def meta_description(obj)
    if obj.is_a?(String)
      content_for :meta_description, obj
    else
      content_for :meta_description, obj.to_description
    end
  end

  def meta_keywords(obj)
    if obj.is_a?(String)
      content_for :meta_keywords, obj
    elsif obj.is_a?(Array)
      content_for :meta_keywords, obj.join(",")
    else
      content_for :meta_keywords, obj.to_keywords.try(:join, ",")
    end
  end

end
