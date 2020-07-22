class Api::MapItemsController < ApplicationController

  respond_to :json

  skip_before_action :authenticate_user!

  def index
    bounds = URI.unescape(params[:bounds]) rescue ''
    bounds = bounds.split(',').map &:to_f
    point_1 = bounds[0, 2].reverse
    point_2 = bounds[2, 2].reverse

    result = case params[:filter]
    when 'events'
      Event.in_bounds point_1, point_2
    when 'pois'
      Poi.in_bounds point_1, point_2
    when 'routes'
      Route.in_bounds point_1, point_2
    when 'users'
      User.in_bounds(point_1, point_2).to_a - [current_user]
    end
    render json: result, root: false
  end

end
