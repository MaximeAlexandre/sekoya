class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    @address = ""
    @address = current_user.address if user_signed_in?
  end

  def senior
    @bookings = Booking.where(senior_id: current_user.id).order(date: :asc, start_time: :asc)
    @booking_next = @bookings.first unless @bookings.empty?
    @senior_week = senior_week(@bookings)
    @en_attente = pending(@bookings)
    @avenir = futur(@bookings)
  end

  def helper
    @bookings = Booking.where(helper_id: current_user.id).order(date: :asc, start_time: :asc)
    @booking_next = @bookings.first unless @bookings.empty?
    @helper_day = helper_day(@bookings)
    @en_attente = pending(@bookings)
    @avenir = futur(@bookings)
  end

  private

  def helper_day(list)
    list.where(date: Date.today)
  end

  def senior_week(list)
    week = [Date.today]
    (1..6).each { |i| week << Date.today + i }
    list.where(date: week)
  end

  def pending(list)
    list.where(status: "pending")
  end

  def futur(list)
    list.where("date >= ?", Date.today)
  end

end
