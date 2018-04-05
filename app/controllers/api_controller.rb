class ApiController < ApplicationController
  # before_action :authenticate_user!, only: [:create, :new, :edit, :update, :destroy]
  # before_action :set_request!, only: [:create_event, :redirect, :callback, :calendars]
  # before_action :set_event_show, only: [:edit, :update, :destroy]
  access all: [], user: [], admin: :all

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
  rescue Google::Apis::AuthorizationError
    response = client.refresh!

    session[:authorization] = session[:authorization].merge(response)

    retry
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

  def client_options
    {
      client_id: ENV.fetch('GOOGLE_CLIENT_ID'),
      client_secret: ENV.fetch('GOOGLE_CLIENT_SECRET'),
      authorization_uri: 'https://accounts.google.com/o/oauth2/auth',
      token_credential_uri: 'https://accounts.google.com/o/oauth2/token', 
      scope: Google::Apis::CalendarV3::AUTH_CALENDAR,
      redirect_uri: url_for(:action => :callback)
    }
  end

  def callback_options
    {
      client_id: ENV.fetch('GOOGLE_CLIENT_ID'),
      client_secret: ENV.fetch('GOOGLE_CLIENT_SECRET'),
      token_credential_uri: 'https://accounts.google.com/o/oauth2/token',
      redirect_uri: url_for(:action => :callback),
      code: params[:code]
    }
  end
end
