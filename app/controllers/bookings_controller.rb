class BookingsController < ApplicationController

  def new
    @booking = Booking.new
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.helper_id = @helper_id
    @booking.senior_id = @senior_id
    if @booking.save
      redirect_to booking_path(@booking)
    else
      render :new
    end
  end

  def show
  end

  def update
  end

  private

  def booking_params
    params.require(:booking).permit(:date, :start_time, :end_time, :task, :comment)
end
