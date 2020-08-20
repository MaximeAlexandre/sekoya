class BookingsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:create, :edit_tasks]
  before_action :set_booking, only: [:show, :edit_tasks, :edit_validation, :update_task, :update_validation, :update_status]

  def new
    @booking = Booking.new
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.booking_step = 0
    @booking.status = "pending"
    @helper = User.find(params[:id])
    @booking.helper = @helper
    if @booking.save
      redirect_to tasks_path(@booking)
    else
      render :show
    end
  end

  def show
    @tasks = Task.where(booking_id: @booking.id)
  end

  def edit_tasks
  end

  def edit_validation
    @tasks = Task.where(booking_id: @booking.id)
    @diplomas = Diploma.where(user_id: @booking.helper.id)
  end

  def update_task
    tasks = params.select { |_key, value| value == "1" }.keys
    tasks.each do |task|
      Task.create(name: task, booking: @booking)
    end
    @senior = current_user
    @booking.senior = @senior
    @booking.booking_step += 1
    @booking.save
    redirect_to validation_path(@booking)
  end

  def update_validation
    @booking.booking_step += 1
    @booking.save
    redirect_to booking_path(@booking)
  end


  def update_status
    if params[:status] == "validate"
      @booking.update(status: "accepté")
    elsif params[:status] == "refused"
      @booking.update(status: "refusé")
    elsif params[:status] == "cancelled"
      @booking.update(status: "annulé")
    end
  end

  private

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def booking_params
    params.permit(:date, :start_time, :end_time)
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
