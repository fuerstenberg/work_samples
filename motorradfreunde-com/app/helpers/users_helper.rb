module UsersHelper

  def link_to_user(user)
    link_to user, class: :link_to_user do
      content_tag(:i, '', class: "icon-user") + user.to_s
    end
  end

  def span_to_user(user)
    content_tag :span, user do
      content_tag(:i, '', class: "icon-user") + user.to_s
    end
  end

end
