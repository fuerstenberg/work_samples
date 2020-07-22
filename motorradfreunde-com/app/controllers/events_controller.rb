class EventsController < ApplicationController

  layout 'fullscreen_formular', only: [:new, :create, :edit, :update]

  skip_before_action :authenticate_user!, only: [:index, :show]
  before_filter :set_event, only: [:show, :edit, :update, :destroy]
  after_filter :count_impression, only: :show

  has_scope :next_week, only: :index, type: :boolean
  has_scope :near do |controller, scope, value|
    if controller.current_user and controller.current_user.geocoded?
      scope.near_by(controller.current_user, value.to_i)
    else
      scope
    end
  end

  def index
    @events = apply_scopes(Event).upcoming
    if params[:query]
      @events = @events.search params[:query], page: params[:page]
    else
      @events = @events.page(params[:page]).per 30
    end
  end

  def show
    authorize! :read, @event
  end

  def new
    authorize! :create, Event
    @event = Event.new :user_id => current_user.id, :start_at => (Time.now + 1.hour), :end_at => (Time.now + 1.hour)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    authorize! :create, Event
    @event = current_user.events.build(event_params)
    # @event.server_side_geocoding = false
    if @event.save
      SlackNotificationWorker.perform_async "Event created, [#{@event}](#{event_url(@event)})."
      flash[:facebook_event] = @event.id
      redirect_to @event, :notice => "Dein Motorradtermin wurde erfolgreich gespeichert."
    else
      logger.error @event.errors
      render :new
    end
  end

  def edit
    authorize! :update, @event
    if @event.user == current_user or current_user.admin?
      render :edit
    else
      redirect_to @event
    end
  end

  def update
    authorize! :update, @event
    if @event.user == current_user or current_user.admin?
      if @event.update_attributes(event_params)
        SlackNotificationWorker.perform_async "Event updated, [#{@event}](#{event_url(@event)})."
        redirect_to @event, notice: "Dein Termin wurde erfolgreich gespeichert!"
      else
        render :edit
      end
    else
      redirect_to @event
    end
  end

  def destroy
    authorize! :destroy, @event
    @event.destroy
    redirect_to :events, notice: 'Der Termin wurde gelöscht!'
  end

  private

  def set_event
    @event = Event.find_by(slug: params[:id]) rescue Event.find_by(slug: params[:id][ params[:id].index('-')+1..-1 ])
  rescue Mongoid::Errors::DocumentNotFound => e
    redirect_to :events, status: 301
  end

  def event_params
    params.require(:event).permit :title, :start_at, :end_at, :hide_time, :description, :url, :type, :user_id,
      address_attributes: [
        :city,
        :coordinates,
        :country,
        :country_code,
        :floor,
        :latitude,
        :longitude,
        :postal_code,
        :region,
        :route,
        :state,
        :state_code,
        :street,
        :street_number,
        :zip,
      ]
  end

end
