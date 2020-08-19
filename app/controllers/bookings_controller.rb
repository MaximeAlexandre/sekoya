class BookingsController < ApplicationController
  def new
    @booking = Booking.new
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.booking_step = 0
    @helper = User.find(params[:id])
    @senior = current_user
    @booking.helper = @helper
    @booking.senior = @senior
    if @booking.save
      redirect_to tasks_path(@booking)
    else
      render :new
    end
  end

  def show
    @booking = Booking.find(params[:id])
  end

  def edit_tasks
    @booking = Booking.find(params[:id])
  end

  def edit_validation
    @booking = Booking.find(params[:id])
  end

  def update
    @booking = Booking.find(params[:id])

    if @booking.booking_step == 0
      @tasks = []
      @booking = Booking.find(params[:id])
      if @booking.task.present?
        @booking.booking_step += 1
        redirect_to tasks_path(@booking)
      else
        render :new
      end
    elsif @booking.booking_step == 1
      @booking = Booking.find(params[:id])
      @booking.booking_step += 1
    else
      if params[:status] == "validate"
        @booking.update(status: "accepté")
      elsif params[:status] == "refused"
        @booking.update(status: "refusé")
      elsif params[:status] == "cancelled"
        @booking.update(status: "annulé")
      end
      redirect_to booking_path(@booking)
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:date, :start_time, :end_time)
  end

  def booking_params_tasks
    params.require(:booking).permit(:task) #:comment

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
