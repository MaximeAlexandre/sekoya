class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    @address = ""
    @address = current_user.address if user_signed_in?
  end

  def senior
    @bookings = Booking.where("booking_step = ? and senior_id = ?", 2, current_user.id).order(date: :asc, start_time: :asc)
    @booking_next = @bookings.find_by(status: "accepté")
    list_4_senior(@bookings)
    favoris
  end

  def helper
    @bookings = Booking.where("booking_step = ? and helper_id = ?", 2, current_user.id).order(date: :asc, start_time: :asc)
    @booking_next = @bookings.find_by(status: "accepté")
    list_4_helper(@bookings)
  end

  private

  def helper_day(list)
    list.where(date: Date.today).where(status: "accepté")
  end

  def senior_week(list)
    # week = [Date.today] ; (1..6).each { |i| week << Date.today + i }; list.where(date: week)
    list.where("date >= ? and date <= ? and status = ?", Date.today, Date.today+6, "accepté")
  end

  def pending(list)
    list.where(status: "pending")
  end

  def futur(list)
    list.where("date >= ? and status = ?", Date.today, "accepté")
  end

  def past(list)
    list.where("date < ? or status = ? or status = ?", Date.today, "refusé", "annulé")
  end

  def list_4_senior(bookings)
    @senior_week = senior_week(bookings)
    @pending = pending(bookings)
    @avenir = futur(bookings)
    @historique = past(bookings)
  end

  def list_4_helper(bookings)
    @helper_day = helper_day(bookings)
    @pending = pending(bookings)
    @avenir = futur(bookings)
    @historique = past(bookings)
  end

  def favoris
    @favoris = Booking.joins(:favoris).where(senior: current_user)
    @favoris_helper = []
    @favoris.each { |booking| @favoris_helper << booking.helper }
  end
end
