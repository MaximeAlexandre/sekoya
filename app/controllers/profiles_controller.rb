class ProfilesController < ApplicationController
  before_action :set_user, only: :helper_details
  skip_before_action :authenticate_user!, only: [:helper_list, :helper_details]

  def helper_list
    if params[:address_input].present?
      @address = params[:address_input]
      @helpers = User.where(role: "helper")
      @diplomas_name = diplomas_name_list

      near_helpers = @helpers.near(params[:address_input], 10)
      @helpers = near_helpers_filter(params, near_helpers)

      @cheaper_helper = @helpers.min_by(&:price)
      @best_note_helper = User.find(best_average_rating(@helpers)[:helper_id])
    else
      redirect_to '#'
    end
  end

  def helper_details
    @diplomas = Diploma.where(user_id: @helper.id)
    @exist_booking = Booking.where(helper_id: @helper.id).first
    @registration_duration = registered_for(@helper)
    @booking = Booking.new
    @booking.helper = @helper
    @booking.senior = current_user
    details_reviews(@helper)
    today_start_time
    favoris
  end

  private

  def set_user
    @helper = User.find(params[:id])
  end

  def registered_for(helper)
    registered_for_year = (Date.today - helper.created_at.to_date).to_i / 365
    registered_for_month = (Date.today.month - helper.created_at.to_date.month)
    registered_for_month += 12 if registered_for_month.negative?

    if registered_for_year.zero? && registered_for_month.zero?
      "moins de 1 mois"
    elsif registered_for_year.zero?
      "#{registered_for_month} mois"
    else
      "plus de #{registered_for_year} ans"
    end
  end

  def diplomas_name_list
    diplomas_list = []
    Diploma.all.each { |diploma| diplomas_list << diploma.name }
    diplomas_list.uniq
  end

  def near_helpers_filter(params, near_helpers)
    if params[:diploma].present? && params[:car].present?
      helpers = diploma_filter(params, near_helpers)
      car_filter(params, helpers)
    elsif params[:diploma].present?
      diploma_filter(params, near_helpers)
    elsif params[:car].present?
      car_filter(params, near_helpers)
    else
      near_helpers
    end
  end

  def car_filter(params, near_helpers)
    return near_helpers.select { |helper| helper.car.to_s == params[:car] } if params[:car] != "Tous"

    near_helpers
  end

  def diploma_filter(params, near_helpers)
    return near_helpers.select { |helper| helper.diplomas.where(name: params[:diploma]).present? } if params[:diploma] != "Toutes"

    near_helpers
  end

  def best_average_rating(helpers)
    average_rating_helpers = []
    helpers.each do |helper|
      reviews = reviews_list(helper)
      next if reviews.empty?

      average_rating_helpers << {
        helper_id: helper.id,
        average_note: reviews.collect(&:note).sum.to_f / reviews.length
      }
    end
    average_rating_helpers.max_by { |rating| rating[:average_note] }
  end

  def reviews_list(helper)
    reviews = []
    bookings = Booking.where(helper_id: helper.id)
    bookings.each do |booking|
      review = Review.find_by(booking_id: booking.id)
      reviews << review unless review.nil?
    end
    reviews
  end

  def average_rating(reviews)
    reviews.collect(&:note).sum.to_f / reviews.length unless reviews.empty?
  end

  def details_reviews(helper)
    @reviews = reviews_list(helper)
    @average_rating = average_rating(@reviews)
  end

  def today_start_time # Date.today
    time = Time.now
    @starting_hour = time.hour + 1
    @starting_hour += 1 unless time.min == 0
  end

  def favoris
    @favoris = Booking.joins(:favoris).where(senior: current_user)
    @favoris_helper = []
    @favoris.each { |booking| @favoris_helper << booking.helper }
  end
end
