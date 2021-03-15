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
    @review = Review.new
    @diplomas = Diploma.where(user_id: @booking.helper.id)
    @total = (@booking.end_time - @booking.start_time) / 3600 * @booking.helper.price
    @reviews = reviews_list
    @average_rating = average_rating(@reviews)
    map(@booking)
  end

  def edit_tasks
  end

  def edit_validation
    @tasks = Task.where(booking_id: @booking.id)
    @diplomas = Diploma.where(user_id: @booking.helper.id)
    @reviews = []
    helper = @booking.helper
    bookings = Booking.where(helper_id: helper.id)
    bookings.each do |booking|
      review = Review.find_by(booking_id: booking.id)
      @reviews << review unless review.nil?
    end
    @total = (@booking.end_time - @booking.start_time) / 3600 * @booking.helper.price
    @average_rating = @reviews.collect(&:note).sum.to_f / @reviews.length unless @reviews.empty?
  end

  # Update -----------------

  def update_task
    tasks = params.select { |_key, value| value == "on" }.keys
    tasks.each do |task|
      Task.create(name: task, booking: @booking)
    end
    @booking.update(booking_step: 1, senior: current_user)
    redirect_to validation_path(@booking)
  end

  def update_validation
    @booking.update(comment: params[:comment], booking_step: 2)
    redirect_to senior_path
  end

  def update_status
    if params[:status] == "accepté"
      @booking.update(status: params[:status])
      if params[:path] == "booking"
        redirect_to booking_path(@booking)
      else
        redirect_to helper_path
      end
    elsif params[:status] == "refusé"
      @booking.update(status: params[:status])
      if params[:path] == "booking"
        redirect_to booking_path(@booking)
      else
        redirect_to helper_path
      end
    elsif params[:status] == "annulé"
      @booking.update(status: params[:status])
      redirect_to senior_path
    end
  end

  private

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def booking_params
    params[:date] = params[:date].to_datetime.change(:offset => "+01:00") + params[:slider_1].to_i.hour
    params[:hour_number] = params[:slider_2].to_i - params[:slider_1].to_i
    params[:start_time] = params[:slider_1]
    params[:end_time] = params[:slider_2]
    #params[:date] = params[:date].to_datetime.change(:offset => "+01:00") + params[:start_time].to_i.hour
    #params[:hour_number] = params[:end_time].to_i - params[:start_time].to_i
    params.permit(:date, :start_time, :end_time, :hour_number)
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

  # Reviews --------------------

  def reviews_list
    reviews = []
    bookings = Booking.where(helper_id: @booking.helper.id)
    bookings.each do |booking|
      review = Review.find_by(booking_id: booking.id)
      reviews << review unless review.nil?
    end
    reviews
  end
  def average_rating(reviews)
    reviews.collect(&:note).sum.to_f / reviews.length unless reviews.empty?
  end

  # Map -----------------------

  def map(booking)
    @flats = User.where(id: booking.senior).geocoded # returns flats with coordinates

    @markers = @flats.map do |flat|
      {
        lat: flat.latitude,
        lng: flat.longitude
      }
    end
  end
end
