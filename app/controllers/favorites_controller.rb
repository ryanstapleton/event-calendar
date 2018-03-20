class FavoritesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event, only: [:destroy]

  def new
    @favorite = Favorite.new
  end

  def create
    @favorite = Favorite.create!(user_id: current_user.id, event_id: params[:event_id])

    respond_to do |format|
      if @favorite.save
        format.html { redirect_back fallback_location: root_path }
      end
    end
  end

  def destroy
    @favorite.destroy
    respond_to do |format|
      format.html { redirect_back fallback_location: root_path }
    end
  end

  private

  def set_event
    @favorite = Favorite.find(params[:id])
  end


end