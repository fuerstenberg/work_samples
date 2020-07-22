class Api::ApplicationController < ActionController::Base

  respond_to :json

  # TODO: add tests for using with root options and without it
  def default_serializer_options
    options = {}
    if params[:root] == "false"
      options.merge! root: false
    elsif params[:root] and params[:root] != "true"
      options.merge! root: params[:root]
    end
    options
  end

end
