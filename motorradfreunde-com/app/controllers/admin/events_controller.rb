class Admin::EventsController < Admin::ApplicationController

  before_filter :find_event

  def index
    @events = Event.upcoming.page params[:page]
  end

  def show
  end

  def new
    @event = Event.new start_at: (Time.now + 1.hour), end_at: (Time.now + 1.hour), hide_time: true
  end

  def create
    @event = current_user.events.build(params[:event])
    if @event.save
      redirect_to [:admin, :events], :notice => "Dein Motorradtermin wurde erfolgreich gespeichert."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @event.update_attributes(params[:event])
      redirect_to [:admin, :events], :notice => "Dein Motorradtermin wurde erfolgreich gespeichert."
    else
      render :edit
    end
  end

  def destroy
    @event.destroy
    redirect_to [:admin, :events], :notice => "Dein Motorradtermin wurde erfolgreich entfernt."
  end

  private

  def find_event
    @event = Event.find(params[:id]) if params[:id]
  end

end
