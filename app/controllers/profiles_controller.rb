class ProfilesController < ApplicationController
  before_action :set_user, only: :helper_details
  skip_before_action :authenticate_user!, only: [:helper_list, :helper_details]

  def helper_list
    if params[:address_input].present?
      @address = params[:address_input]
      @helpers = User.where(role: "helper")
      @reviews = []
      @diplomas_name = diplomas_name_list
      near_helpers = @helpers.near(params[:address_input], 10)
      @helpers = near_helpers_filter(params, near_helpers)
    else
      redirect_to '#'
    end
  end

  def helper_details
    @diplomas = Diploma.where(user_id: @helper.id)
    @registration_duration = registered_for(@helper)
    @booking = Booking.new
    @booking.helper = @helper
    @booking.senior = current_user
    @reviews = []
    bookings = Booking.where(helper_id: @helper.id)
    bookings.each do |booking|
      review = Review.find_by(booking_id: booking.id)
      @reviews << review unless review.nil?
    end
    @average_rating = Review.average(:note)
  end

  private

  def set_user
    @helper = User.find(params[:id])
    # authorize @helper
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
    if params[:diploma].present? && params[:diploma] != "Certifications" && params[:car].present?
      near_helpers = near_helpers.select { |helper| helper.diplomas.where(name: params[:diploma]).present? }
      near_helpers.select { |helper| helper.car.to_s == params[:car] }
    elsif params[:diploma].present? && params[:diploma] != "Certifications"
      near_helpers.select { |helper| helper.diplomas.where(name: params[:diploma]).present? }
    elsif params[:car].present?
      near_helpers.select { |helper| helper.car.to_s == params[:car] }
    else
      near_helpers
    end
  end
end
