module  ViewHelper

  def link_to_and_mark_as_active(link, path, id=nil)
    haml_tag :li, id: id, class: (current_page?(path) ? 'active' : 'inactive') do
      concat link_to link, path
    end
  end

  def markdown(content)
    return if content.blank?
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML,
        autolink: true, space_after_headers: true)
    raw markdown.render(content)
  end

end
