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

    # schedule
    @min = 7
    @max = 20.5
    @busy = busy_load(@helper.id) #remove @ ?
    @sch_spots = sch_load(@helper.id) #remove @ ?
    @unavailable_today = unavailable_today(@min, @max) #remove @ ?
    list_unavailable = list_unavailable(@busy, @sch_spots, @unavailable_today, @min, @max)
    unavailable_days = unavailable_days(list_unavailable, @min, @max)

    # first day
    @first_day = first_day(list_unavailable, unavailable_days).to_date ###
    @is_today = @first_day == Date.today # 
    first_day_data = list_unavailable.find_all { |dt| dt.to_date == @first_day}
    @first_day_spots = first_day_analysis(first_day_data, @min, @max)
    @starting_value = @min.step(@max, 0.5).find { |h| !@first_day_spots.include?(h) }

    # string convert
    @unavailable_days = convert_to_string(unavailable_days)
    @busy_all_string = convert_to_string(list_unavailable)
    @first_day_spots_string = convert_to_string(first_day_data)
  end

  private

def first_day_analysis (first_day_data, min, max)
  busy_temp = first_day_data.map{ |busy| busy.min == 0 ? busy.hour.to_f : busy.hour + 0.5}
  half_hours = []
  min.step(max, 0.5).each do |t|
    condition_1 = busy_temp.include?(t + 0.5) && busy_temp.include?(t - 0.5)
    condition_2 = t == min && busy_temp.include?(t + 0.5)
    condition_3 = t == max && busy_temp.include?(t - 0.5)
    conditions = condition_1 || condition_2 || condition_3
    half_hours << t if conditions && !busy_temp.include?(t)
  end
  return busy_temp.concat(half_hours).sort
end
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

# V3

  def busy_convert(busy_list)
    busy_spots = []
    busy_list.each do |b|
      # b format [date, nbr d'heures]
      # add moving time : start = 1-0.5 = 0.5, max = b[1]+0.5
      0.5.step(b[1]+0.5,0.5).each do |h|
        busy_spots << b[0].to_time + (h-1).hour
      end
    end
    return busy_spots.sort
  end

  def unavailable_today(min, max_all)
    today = []
    time = Time.now
    start = time.beginning_of_day
    time.hour + 2 <= max_all ? max = time.hour + 2 : max = max_all
    min.step(max, 0.5) {|t|
      t.to_s.end_with?(".5") ? today << start.change({ hour: t.to_i, min: 30}) : today << start.change({ hour: t.to_i })
    }
    return today
  end

  def list_unavailable(busy, sch, today, min, max)
    unavailable = sch
    busy_convert(busy).each do |b|
      unavailable << b unless unavailable.include?(b)
    end
    today.each do |t|
      unavailable << t unless unavailable.include?(t)
    end
    min.to_s.end_with?(".5") ? second_spot = [min.to_i + 1, 0] : second_spot = [min.to_i, 30]
    max.to_s.end_with?(".5") ? second_last = [max.to_i, 0] : second_last = [max.to_i - 1, 30]
    memory = unavailable.sort
    memory.each do |u|
      minutes = u.min
      unavailable << u - 0.5.hour if u.hour == second_spot[0] && minutes == second_spot[1] && !unavailable.include?(u - 0.5.hour)
      unavailable << u + 0.5.hour if u.hour == second_last[0] && minutes == second_last[1] && !unavailable.include?(u + 0.5.hour)
      unavailable << u + 0.5.hour if unavailable.include?(u + 1.hour) && !unavailable.include?(u + 0.5.hour)
      unavailable << u - 0.5.hour if unavailable.include?(u - 1.hour) && !unavailable.include?(u - 0.5.hour)
    end
    return unavailable.sort
  end

  def unavailable_days (list_unavailable, min, max)
    days_test = {}
    disabled_days = []
    list_unavailable.each do |dt|
      key_name = dt.to_date.to_s
      if days_test[key_name].nil?
        days_test[key_name] = [dt]
      else
        days_test[key_name] << dt
      end
    end
    spots = min.step(max, 0.5).to_a
    days_test.each_key do |key|
      spots_test = min.step(max, 0.5).to_a
      if days_test[key].length == spots.length
        disabled_days << key
      else
        busy_spots = days_test[key].map {|h| h.min == 0 ? h.hour : h.hour + 0.5}
        busy_spots.each{|spot| spots_test.delete(spot)}

        day_is_unavailable = true
        spots_test.each do |spot|
          if spot == spots_test[-1]
          else
            day_is_unavailable = false if spots_test.include?(spot + 0.5)
            break if spots_test.include?(spot + 0.5)
          end
        end
        disabled_days << key if day_is_unavailable == true
      end
    end
    return disabled_days
  end

  def first_day(list_unavailable, unavailable_days)
    condition_1 = unavailable_days.include?(Date.today.to_s)
    condition_2 = Time.now.hour > 18
    condition_3 = Date.today.wday == 6
    condition_4 = Date.today.wday == 0
    # add discrimination disponibilités todays
    if condition_1 || condition_2 || condition_3 || condition_4
    else
      return Date.today.to_s
    end
    date = Date.today + 1.day
    date += 2.day if date.wday == 6
    date += 1.day if date.wday == 0
    until !unavailable_days.include?(date.to_s)
      date += 1.day
    end
    return date.to_s
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
