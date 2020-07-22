module TitleHelper

  def title(object = nil, str = nil, &block)
    if block_given?
      content_for :title, &block
    elsif object.is_a?(User)
      content_for :title do
        its_title(object.to_title, str)
      end
    elsif object.is_a?(String)
      content_for :title do
        [object, str].compact.join(" – ")
      end
    else
      content_for :title do
        [object.to_title, str].compact.join(" – ")
      end
    end
  end

  def subtitle(object = nil, str = nil, &block)
    if block_given?
      content_for :subtitle, &block
    elsif object.is_a?(String)
      content_for :subtitle, [object, str].compact.join(" – ")
    else
      content_for :subtitle, [object.to_subtitle, str].compact.join(" – ")
    end
  end

  def its_title(str1 = nil, str2 = nil)
    str1 = str1.to_s
    str2 = str2.to_s
    mapping = %w(s z ß)
    if mapping.include?(str1[-1])
      [str1, str2].join(" ").squish
    else
      [str1 + 's', str2].compact.join(" ").squish
    end
  end

end
