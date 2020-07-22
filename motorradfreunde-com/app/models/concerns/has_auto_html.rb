module Concerns::HasAutoHtml

  extend ActiveSupport::Concern

  included do
  end

  def auto_html(text)
    AutoHtml::Pipeline.new(
      AutoHtml::HtmlEscape.new,
      # TODO: AutoHtml::GoogleMap.new(width: 600, height: 450, link_text: ""),
      # TODO: AutoHtml::Youtube.new(width: 600, height: 450),
      # TODO: AutoHtml::Vimeo.new(width: 600, height: 450),
      AutoHtml::Markdown.new,
      AutoHtml::Image.new(proxy: nil, alt: nil),
      AutoHtml::Link.new(target: '_blank', rel: nil),

      # AutoHtml::Emoji, width: 20, height: 20, asset_root: '/images'
      # AutoHtml::HtmlEscape
      # AutoHtml::Image, proxy: nil, alt: nil
      # AutoHtml::Link, target: nil, rel: nil
      # AutoHtml::Markdown
      # AutoHtml::SimpleFormat
    ).call(text)
  end

end


# TODO: auto_html
#   google_map  width: 600, height: 450, link_text: ""
#   html_escape
#   image
#   link        target: "_blank", rel: "nofollow"
#   redcarpet
#   simple_format
#   vimeo       width: 600, height: 450
#   youtube     width: 600, height: 450
