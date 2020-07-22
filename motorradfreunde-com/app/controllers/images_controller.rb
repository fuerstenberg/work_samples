class ImagesController < ApplicationController

  before_action :set_imageable
  before_action :set_image, only: [:edit, :update, :destroy, :avatar]

  def index
    @images = @imageable.images.all
  end

  def new
    @image = @imageable.images.build
    authorize! :create, @image
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @image = @imageable.images.build(image_params)
    authorize! :create, @image
    @image.user = current_user
    if @image.is_uploadable_by?(current_user) and @image.save
      redirect_to :back, :notice => I18n.t("images.controller.create.notice")
    else
      redirect_to :back, :alert => I18n.t("images.controller.create.alert")
    end
  end

  def edit
    authorize! :update, @image
  end

  def update
    authorize! :update, @image
    @image.user = current_user
    if @image.is_uploadable_by?(current_user) and @image.update_attributes(image_params)
      redirect_to :back, :notice => I18n.t("images.controller.update.notice")
    else
      redirect_to :back, :alert => I18n.t("images.controller.update.alert")
    end
  end

  def destroy
    authorize! :destroy, @image
    if @image.is_deletable_by?(current_user)
      @image.destroy
    end
    redirect_to :back, :notice => I18n.t("images.controller.destroy.notice")
  end

  def avatar
    authorize! :update, @image
    @image.set_as_avatar
    redirect_to :back
  end

  def sort
    authorize! :update, @image
    Image.sort params, current_user
    render :nothing => true
  end

  private

  def set_imageable
    # @imageable ||= Image.find(params[:id]).imageable if params[:id]
    @imageable ||= @article
    @imageable ||= @bike
    @imageable ||= @event
    @imageable ||= @forum
    @imageable ||= @poi
    @imageable ||= @user
    @imageable ||= current_user
  end

  def set_image
    @image = @imageable.images.find params[:id]
  end

  def image_params
    params.require(:image).permit(:file, :original_filename, :content_type, :headers) rescue {}
  end

end
