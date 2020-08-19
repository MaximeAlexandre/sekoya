class ProfilesController < ApplicationController
  before_action :set_user, only: :helper_details
  skip_before_action :authenticate_user!, only: [:helper_list, :helper_details]

  def helper_list
    session[:address_input] = params[:address_input]

    if session[:address_input].present?
      @helpers = User.where(role: "helper")
      @helpers.near(session[:address_input], 10)
    else
      redirect_to '#'
    end
  end

  def helper_details
    @registration_duration = registered_for(@helper)
    @booking = Booking.new
    @booking.helper = @helper
    @booking.senior = current_user
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
end
