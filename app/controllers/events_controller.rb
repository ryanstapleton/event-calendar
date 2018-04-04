class EventsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :new, :edit, :update, :destroy]
  before_action :set_event, only: [:show, :edit, :update, :destroy, :approve, :reject]
  before_action :set_event_show, only: [:edit, :update, :destroy]
  access all: [:show, :index], user: {except: [:admin]}, admin: :all
  
  def index
    @events = Event.where(status: :approved).order(date: :desc)
    @rsvps = current_user.rsvps if current_user
    @favorites = current_user.favorites if current_user
  end

  def show
    @event = Event.find(params[:id])
    @location = "2912+Executive+Pkwy,Lehi,UT"
  end


  def new
    @event = Event.new
  end


  def edit
  end

  def create
    @event = current_user.events.create!(event_params)
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
    respond_to do |format|
      format.html { redirect_to admin_path, notice: 'The event was approved.' }
    end

    # TODO: API CALL - insert event into API
  end

  def reject
    @event.rejected!
    respond_to do |format|
      format.html { redirect_to admin_path, notice: 'The event was rejected.' }
    end
  end

  def redirect
    client = Signet::OAuth2::Client.new(client_options)

    redirect_to client.authorization_uri.to_s
  end

  def callback
    client = Signet::OAuth2::Client.new(callback_options)

    response = client.fetch_access_token!

    session[:access_token] = response['access_token']

    redirect_to url_for(:action => :calendars)
  end

  def calendars
    client = Signet::OAuth2::Client.new(access_token: session[:access_token])

    service = Google::Apis::CalendarV3::CalendarService.new

    service.authorization = client

    @calendar_list = service.list_calendar_lists
  end

  def create_event
    client = Signet::OAuth2::Client.new(client_options)
    client.update!(session[:authorization])

    service = Google::Apis::CalendarV3::CalndarService.new
    service.authorization = client

    today = Date.today

    event = Google::Apis::CalendarV3::Event.new({
      start: Google::Apis::CalendarV3::EventDateTime.new(date:today + 1),
    end: Google::Apis::CalendarV3::EventDateTime.new(date:today + 2),
    summary: 'New Event via Google API call!'
      })

    service.insert_event(params[:calendar_id], event)

    redirect_to events_url(calendar_id: params[:calendar_id])
  end

  private

    def set_event
      @event = Event.find(params[:id])
    end

    def set_event_show
      @event = current_user.events.find(params[:id])

      rescue ActiveRecord::RecordNotFound
      redirect_to(root_url, :notice => 'Record not found')
    end

    def event_params
      params.require(:event).permit(:title, :body, :main_image, :date, :location)
    end

    def client_options
      {
        client_id: Rails.application.secrets.google_client_id,
        client_secret: Rails.application.secrets.google_client_secret,
        authorization_uri: 'https://accounts.google.com/o/oauth2/auth',
        token_credential_uri: 'https://accounts.google.com/o/oauth2/token', 
        scope: Google::Apis::CalendarV3::AUTH_CALENDAR,
        redirect_uri: url_for(:action => :callback)
      }
    end

    def callback_options
      {
        client_id: Rails.application.secrets.google_client_id,
        client_secret: Rails.application.secrets.google_client_secret,
        token_credential_uri: 'https://accounts.google.com/o/oauth2/token',
        redirect_uri: uri_for(:action => :callback)
        code: params[:code]
      }
    end
end