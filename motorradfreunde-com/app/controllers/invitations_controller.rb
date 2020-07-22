class InvitationsController < ApplicationController

  def index
  end

  def create
    authorize! :update, current_user
    if @user and current_user.invite @user
      notice = "Du hast #{@user} eine Freundschaftsanfrage gesendet."
    end
    redirect_to :back, notice: notice
  end

end
