class Admin::ApplicationController < ApplicationController

  before_filter :require_admin

  private

  def require_admin
    unless current_user.admin?
      redirect_to root_url
      return false
    end
  end

end
