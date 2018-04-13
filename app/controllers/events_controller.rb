class EventsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :new, :edit, :update, :destroy, :approve, :reject]
  before_action :set_event, only: [:show, :edit, :update, :destroy, :approve, :reject]
  before_action :modify_event, only: [:edit, :update, :destroy]
  access all: [:show, :index], user: {except: [:admin]}, admin: :all
  
  def index
    @events = Event.where(status: :approved).order(date: :desc)
    @rsvps = current_user.rsvps if current_user
    @favorites = current_user.favorites if current_user
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
    session[:return_to] = request.referer
  end

  def edit
    session[:return_to] = request.referer
  end

  def create
    @event = current_user.events.new(event_params)
    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Your event was created'}
      else
        format.html {
          render :new
        }
      end
    end
  end

  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Your event was updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Your event was deleted.' }
    end
  end

  def approve
    @event.approved!

    @calendar = GoogleCalendarWrapper.new(current_user)
    @calendar.insert(@event.format_for_google)
    
    respond_to do |format|
      format.html { redirect_to admin_path, notice: 'The event was approved.' }
    end
  end

  def reject
    @event.rejected!
    respond_to do |format|
      format.html { redirect_to admin_path, notice: 'The event was rejected.' }
    end
  end

  private

    def set_event
      @event = Event.find(params[:id])
    end

    def modify_event
      if current_user.roles.include?(:admin)
        @event = Event.find(params[:id])
      else
        @event = current_user.events.find(params[:id])
      end

      rescue ActiveRecord::RecordNotFound
      redirect_to(root_url, :notice => 'Record belongs to another user')
    end

    def event_params
      params.require(:event).permit(:title, :body, :main_image, :start, :end, :location)
    end
end