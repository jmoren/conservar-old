class EventsController < ApplicationController
  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(params[:event])
    @event.user = current_user
    if @event.save
      redirect_to @event, :notice => "Successfully created event."
    else
      render :action => 'new'
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    if @event.update_attributes(params[:event])
      redirect_to @event, :notice  => "Successfully updated event."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to events_url, :notice => "Successfully destroyed event."
  end

  def update_in_calendar
    @event = Event.find(params[:id])
    @event.start_at = @event.start_at + params[:delta].to_i.day
    @event.end_at = @event.end_at + params[:delta].to_i.day
    @event.save
    if @event.start_at.day == @event.end_at.day
      render :text => "Se actualizo la fecha de <b>#{@event.title}</b>: #{l @event.start_at, :format => '%d de %B'}"
    else
      render :text => "Se actualizaron las fechas de <b>#{@event.title}</b>: #{l @event.start_at, :format => '%d de %B'} al #{l @event.end_at, :format => '%d de %B'} "
    end
  end
end

