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
      if @helpers.nil? || best_average_rating(@helpers).nil?
        @best_note_helper = nil
      else
        @best_note_helper = User.find(best_average_rating(@helpers)[:helper_id])
      end
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
    @reviews = reviews_list(@helper)
    @average_rating = average_rating(@reviews)
    details_reviews(@helper)
    now = Time.now
    @starting_hour = today_start_time(now)

    favoris

    # schedule busy
    @busy = busy_load(@helper.id) #remove @ ?
    busy_spots = busy_spots(@busy) #remove @ ?
    #schedule free
    @free_spots = sch_load(@helper.id) #remove @ ?
    vs = versus(@free_spots, @busy)
    @free_days_data = free_days(vs).empty? ? Date.today : free_days(vs) #remove @ ?

    # Data jour par defaut
    @free_first_day = @free_days_data.find { |date| date.to_date >= Date.today }
    # discriminer aujourd'hui - start
    if @free_first_day == Date.today.to_s 
      now.min.zero? ? h_today_start = now.hour + 2 : h_today_start = now.hour + 1
      free_first_day_data = vs.find_all {
        |dt| dt.to_date == @free_first_day.to_date && dt.to_time.hour > h_today_start
      }
      if free_first_day_data == []
        @free_first_day = @free_days_data.find { |date| date.to_date > Date.today }
        free_first_day_data = vs.find_all { |dt| dt.to_date == @free_first_day.to_date}
      end
    else
      free_first_day_data = vs.find_all { |dt| dt.to_date == @free_first_day.to_date}
    end
    @is_today = @free_first_day == Date.today.to_s && @starting_hour > 20
    # discriminer aujourd'hui - end
    busy_first_day_data = busy_spots.find_all { |dt| dt.to_date == @free_first_day.to_date}
    @free_first_day_spots_hours = free_first_day_data.map{ |scheduled| scheduled.hour}
    @busy_first_day_spots_hours = busy_first_day_data.map{ |booking| booking.hour}
    @starting_value = @free_first_day_spots_hours.find{|spot|
      @busy_first_day_spots_hours.include?(spot) == false
    }

    # string convert
    @busy_all_string = convert_to_string(busy_spots)
    @busy_all_string = convert_to_string(busy_spots)
    @vs_string = convert_to_string(vs)
    @free_days = convert_to_string(@free_days_data)
    @free_first_day_spots = convert_to_string(free_first_day_data)
    @busy_first_day_spots = convert_to_string(busy_first_day_data)
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
    if params[:diploma] != "Toutes"
      return near_helpers.select { |helper| helper.diplomas.where(name: params[:diploma]).present? }
    end

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

  def today_start_time(time)
    if time.hour >= 22
      starting_hour = time.change(hour: 23, min: 59)
    else
      time.min.zero? ? starting_hour = time.hour + 1 : starting_hour = time.hour + 2
    end
    return starting_hour
  end

  def favoris
    @favoris = Booking.joins(:favoris).where(senior: current_user)
    @favoris_helper = []
    @favoris.each { |booking| @favoris_helper << booking.helper }
  end

  # Disponibilites

  # Schedule LOAD functions -------------------

  def sch_extraction(id, type = "usual")
    return Schedule.where(user: id, sch_type: type)
  end

  def load_convert(sch_db)
    sch_deploy = []
    sch_db.each { |s| sch_deploy += s.occurrences.map { |o| o.to_time } }
    return sch_deploy
  end

  def sch_load(id) # not for save, read only
    return load_convert(sch_extraction(id))
  end

  # Bookings LOAD functions -------------------

  def bookings_list(id)
    return Booking.where(booking_step: 2, helper_id: id)
                  .where("status = ? or status = ?", "accepté", "pending")
                  .order(date: :asc, start_time: :asc) # ? replace start_time par date ?
  end

  def busy_list(bookings)
    busy = []
    bookings.each do |b|
      busy << [b.date.in_time_zone("Paris"), b.hour_number]
    end
    return busy
  end

  def busy_load(id)
    return busy_list(bookings_list(id))
  end

  # busy spots
    def busy_spots(busy)
      busy_1h = []
      busy.each do |booking|
        for i in 1..booking[1]
          busy_1h << booking[0].to_time + (i-1)*60*60
        end
      end
      return busy_1h.sort
    end

  # schedule VS bookings

  def versus(load_deploy, busy)
    # remove the unusable hours
    free = []
    load_deploy.each{ |i| free << i }
    busy.each do |b|
      for i in 0...b[1]
        free.delete(b[0] + i.hour)
      end
    end
    return free
  end

  def free_days(vs)
    days = []
    vs.each { |dt| days << dt.to_date.to_s unless days.include?(dt.to_date.to_s) }
    return days
  end
  
  #formatage

  def convert_to_string(array)
    string = ""
    if array.nil?
    else
      array.each { |e| string = string + e.to_s + "," }
      string.delete_suffix!(',')
    end
    return string
    #if no schedule no array etc
  end
end
