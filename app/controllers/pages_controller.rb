class PagesController < ApplicationController
  before_action :authenticate_user!

  def dashboard
    @events = Event.where(user_id: current_user.id).order(date: :desc)
    @rsvps = User.find(current_user.id).rsvps
    @favorites = User.find(current_user.id).favorites
  end

  def admin
    @pending_events = Event.where(status: :pending).order(date: :desc)
    @approved_events = Event.where(status: :approved).order(date: :desc)
    @rejected_events = Event.where(status: :rejected).order(date: :desc)
  end
end
