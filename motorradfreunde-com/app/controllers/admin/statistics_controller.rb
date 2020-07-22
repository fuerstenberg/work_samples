class Admin::StatisticsController < Admin::ApplicationController

  def index
  end

  def show
    case params[:id]
    when 'objects'        then render json: Statistic.objects
    when 'objects_2'      then render json: Statistic.objects_2
    when 'users_overview' then render json: Statistic.overview
    else
      render_error 404, "Status data not found, have a look into Admin::StatisticsController"
    end
  end

end
