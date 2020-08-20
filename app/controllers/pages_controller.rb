class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    @address = ""
    @address = current_user.address if user_signed_in?
  end

  def senior
    @bookings = Booking.all.where(senior_id: current_user.id).order(start_time: :desc)
    @bookings.empty? ? @booking_next = false : @booking_next = @bookings.first
  end

  def helper
    @bookings = Booking.all.where(helper_id: current_user.id).order(start_time: :desc)
    @bookings.empty? ? @booking_next = false : @booking_next = @bookings.first
  end

  private

end
