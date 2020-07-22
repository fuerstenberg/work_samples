class Admin::RoutesController < Admin::ApplicationController

  def index
    @routes = Route.page params[:page]
  end

  def new
    # @route = current_user.routes.build
    render 'routes/new'
  end

  def destroy
    @route = Route.find(params[:id])
    @route.destroy
    redirect_to :back
  end

end
