module TitleHelper

  def main_action_to(name = nil, options = {}, html_options = {})
    html_options.reverse_merge!({ class: "btn btn-success-outline p-x pull-right" })
    content_for :actions do
      link_to name, options, html_options
    end
  end

  def main_action_to_if(condition, name, options = {}, html_options = {})
    return unless !!condition
    main_action_to name, options, html_options
  end

  def subtitle(subtitle = t('.subtitle'))
    content_for :subtitle, subtitle.to_s
  end

  def title(object = nil)
    if object and count = object.try(:count)
      content_for :title, t('.title', count: count)
    elsif object
      content_for :title, t('.title', title: object.to_s)
    else
      content_for :title, t('.title')
    end
  end

end
