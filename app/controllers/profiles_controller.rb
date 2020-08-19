class ProfilesController < ApplicationController
  before_action :set_user, only: :helper_details
  skip_before_action :authenticate_user!, only: [:helper_list, :helper_details]

  def helper_list
    @address = params[:address_input]
    @helpers = User.where(role: "helper")
    if params[:address_input].present?
      @near_helpers = @helpers.near(params[:address_input], 10)
      if params[:diploma] == "Certifications"
        @near_helpers = @helpers.near(params[:address_input], 10)
      elsif params[:diploma].present?
        @near_helpers = @near_helpers.where(diploma: params[:diploma])
      else
        @near_helpers
      end
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
