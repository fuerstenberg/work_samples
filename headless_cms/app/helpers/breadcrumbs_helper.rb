module BreadcrumbsHelper

  def breadcrumb(title, link = nil)
    content_for :breadcrumbs do
      if title.respond_to?(:to_s)
        title = title.to_s
      end
      if link.present?
        content_tag :li do
          link_to title, link
        end
      else
        content_tag :li, title, class: :active
      end
    end
  end

end
