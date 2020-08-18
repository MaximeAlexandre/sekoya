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
    @booking = Booking.find(params[:id])
  end

  def update
    @booking = Booking.find(params[:id])
    if  params[:status] == "validate"
      @booking.update(status: "accepté")
    elsif params[:status] == "refused"
      @booking.update(status: "refusé")
    elsif params[:status] == "cancelled"
      @booking.update(status: "annulé")
    end
    redirect_to booking_path(@booking)
  end

  private

  def booking_params
    params.require(:booking).permit(:date, :start_time, :end_time, :task, :comment)

    #  id         :bigint           not null, primary key
    #  comment    :text
    #  date       :date
    #  end_time   :time
    #  start_time :time
    #  status     :string
    #  task       :string
    #  created_at :datetime         not null
    #  updated_at :datetime         not null
    #  helper_id  :bigint           not null
    #  senior_id  :bigint           not null
  end

end
