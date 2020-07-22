class Api::Screens::V1::ScreensController < Api::Screens::V1::ApplicationController

  def show
    render json: @screen
  end

end
