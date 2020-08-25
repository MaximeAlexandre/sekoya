class FavorisController < ApplicationController
  def create
    @favori = Favori.new
    @favori.booking = Booking.find(params[:booking])
    @favori.save
    redirect_to profile_path(@favori.booking.helper) if params[:path] == "helper_details"
    redirect_to senior_path if params[:path] == "dashboard"
  end

  def index
    @favoris = Booking.joins(:favoris).where(senior: current_user)
  end

  def destroy
    booking = Booking.find(params[:id])
    favori = Favori.find_by(booking: booking)
    favori.destroy
    redirect_to favoris_index_path if params[:path] == "favoris"
    redirect_to senior_path if params[:path] == "dashboard"
    redirect_to profile_path(booking.helper) if params[:path] == "helper_details"
  end
end
