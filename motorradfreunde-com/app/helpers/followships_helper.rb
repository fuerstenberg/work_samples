module FollowshipsHelper

  def link_to_toggle_followings(current_user, user)
    if current_user and current_user.follows?(user)
      link_to "Diesem Biker nicht folgen", user_follower_path(user, :current_user), method: :delete, class: "btn btn-danger btn-xs", :rel => 'nofollow'
    else
      link_to "Diesem Biker folgen", user_follower_path(user, :current_user), method: :put, class: "btn btn-primary btn-xs", :rel => 'nofollow'
    end
  end

  def link_to_follow(current_user, user, text = "Du folgst")
    if current_user and current_user.follows?(user)
      content_tag :span, "#{text} #{user}", class: "label label-success pull-right"
    elsif current_user != user
      link_to "#{user} folgen", user_follower_path(user, :current_user), method: :put, class: "btn btn-primary btn-xs", :rel => 'nofollow'
    end
  end

  def link_to_toggle_followings_in_btn_group(current_user, user)
    if current_user and current_user.follows?(user)
      link_to "Nicht mehr folgen", user_follower_path(user, :current_user), method: :delete, class: "btn btn-xs btn-default", :rel => 'nofollow'
    else
      link_to "Verfolgen", user_follower_path(user, :current_user), method: :put, class: "btn btn-xs btn-primary", :rel => 'nofollow'
    end
  end

end
