class GreetingsController < ApplicationController

  respond_to :html, :js, :json

  def index
    redirect_to :back # just for some stupid crawlers
  end

  def create
    authorize! :update, current_user
    @user = User.find_by(slug: params[:user_id])
    current_user.greet @user
    respond_to do |format|
      format.html { redirect_to :back, notice: I18n.t('greetings.flash.success')}
      format.json { render json: {success: true, message: I18n.t('greetings.flash.success')}.to_json }
      format.js
    end
  end

end
