class Admin::DelayedJobItemsController < Admin::ApplicationController

  def index
    @delayed_job_items = Kaminari.paginate_array(DelayedJobItem.order(created_at: :asc)).page params[:page]
  end

  def show
    @delayed_job_item = DelayedJobItem.find params[:id]
  end

  def destroy
    @delayed_job_item = DelayedJobItem.find params[:id]
    @delayed_job_item.try :destroy
    redirect_to [:admin, :delayed_job_items]
  end

  def destroy_all
    DelayedJobItem.delete_all
    redirect_to [:admin, :delayed_job_items]
  end

end
