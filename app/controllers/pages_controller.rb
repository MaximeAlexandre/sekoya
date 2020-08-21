class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    @address = ""
    @address = current_user.address if user_signed_in?
  end

  def senior
    @bookings = Booking.where(booking_step: 2).where(senior_id: current_user.id).order(date: :asc, start_time: :asc)
    @booking_next = @bookings.find_by(status: "accepté")
    @senior_week = senior_week(@bookings)
    @pending = pending(@bookings)
    @avenir = futur(@bookings)
    @historique = past(@bookings)
  end

  def helper
    @bookings = Booking.where(helper_id: current_user.id).order(date: :asc, start_time: :asc)
    @booking_next = @bookings.find_by(status: "accepté")
    @helper_day = helper_day(@bookings)
    @pending = pending(@bookings)
    @avenir = futur(@bookings)
    @historique = past(@bookings)
  end

  private

  def helper_day(list)
    list.where(date: Date.today).where(status: "accepté")
  end

  def senior_week(list)
    # week = [Date.today] ; (1..6).each { |i| week << Date.today + i }; list.where(date: week)
    list.where("date >= ? and date <= ?", Date.today, Date.today+6).where(status: "accepté")
  end

  def pending(list)
    list.where(status: "pending")
  end

  def futur(list)
    list.where("date >= ?", Date.today).where.not("status = ? or status = ?", "refusé", "annulé")
  end

  def past(list)
    list.where("date < ? or status = ? or status = ?", Date.today, "refusé", "annulé")
  end

end
