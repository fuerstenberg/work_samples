class Admin::ForumsController < Admin::ApplicationController

  def index
    @forums = Forum.order(:name)
  end

  def show
    @forum = Forum.find params[:id]
  end

  def create
    if @forum = Forum.create(allowed_params)
      redirect_to [:admin, :forums]
    else
      index
      render :index
    end
  end

  def edit
    @forum = Forum.find params[:id]
  end

  def update
    @forum = Forum.find params[:id]
    if @forum.update_attributes(allowed_params)
      redirect_to [:admin, :forums]
    else
      render :edit
    end
  end

  def destroy
    @forum = Forum.find params[:id]
    @forum.destroy
    redirect_to [:admin, :forums]
  end

  private

  def allowed_params
    params.require(:forum).permit!
  end

end
