class FriendshipsController < ApplicationController

  def index
  end

  def create
    authorize! :update, current_user
    current_user.notifications.where(subject: @user, notification_type: 'user.friendship.invite').read!
    if @user and current_user.approve @user
      notice = "Du bist jetzt mit #{@user} befreundet."
    end
    redirect_to :back, notice: notice
  end

  def destroy
    authorize! :update, current_user
    current_user.notifications.where(subject: @user, notification_type: 'user.friendship.invite').read!
    if @user and not current_user.friend_with?(@user)
      current_user.block @user
      notice = "Du willst nicht mit #{@user} befreundet sein."
    elsif @user and current_user.remove_friendship @user
      notice = "Du bist jetzt nicht mehr mit #{@user} befreundet."
    end
    redirect_to :back, notice: notice
  end

end
