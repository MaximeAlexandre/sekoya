class ReviewsController < ApplicationController

  def create

    @review = Review.new(review_params)
    @booking = Booking.find(params[:booking_id])
    @review.booking = @booking
    review = Review.where(booking_id: @booking.id)
    if review.empty?
      @review.save
      redirect_to booking_path(@booking)
    else
      flash[:alert] = "Vous avez déjà commenté cette réservation !"
    end
  end

  private

  def review_params
    params.require(:review).permit(:content, :note)
  end
end
