class CalendarsController < ApplicationController
  def show    
    # @sch_begin = Time.now
    # @sch_end = @sch_begin + 3600 * 24 * 60
    # @sch_duration = @sch_begin + 3600
    # hour = 10
    #@schedule = IceCube::Schedule.new(start = @sch_begin) do |s| # , :end_time => @sch_duration
    #  s.add_recurrence_rule IceCube::Rule.daily
    #  .day(:friday)
    # .hour_of_day(hour)
    #  .minute_of_hour(0)
    #  .second_of_minute(0)
    #end
    #@schedule_rule = @schedule
    #@schedule_days = @schedule.occurrences(@sch_end)

    #warning: si on met @schedule_days_2 = @schedule_days,
    #modifier @schedule_days_2 modifie @schedule_days ...
    @min_h = 7
    @max_h = 20.5
    @format_dt = {
      week_day: ["Dimanche","Lundi","Mardi","Mercredi","Jeudi","Vendredi","Samedi"],
      month:["","Janvier","Fevrier","Mars","Avril","Mai","Juin","Juillet","Août","Septembre","Octobre","Novembre","Decembre"]
    }

    @load = sch_extraction
    @load_deploy = load_convert(@load)

    @bookings = bookings_list
    @busy = busy_list(@bookings)

    @sch_spots = sch_spots(@load_deploy)

    @list_disponibility_classed = data_hashes(@busy, @sch_spots)
    @calendrier = calendrier(@list_disponibility_classed)
  end
  
  def sch_generate
    if params["dates_select"].empty?
      redirect_to sch_form_path
    else
      if params["dates_select"].split(" to ").length == 2
        params_days = params["dates_select"].split(" to ")
      elsif params["dates_select"].split(":").length == 2
        params_days = params["dates_select"].split(":")
      else
        params_days = params["dates_select"].split(" to ")
      end
      if params_days.length == 1
        start_date = params_days.first
        end_date = params_days.first
      else
        start_date = params_days[0]
        end_date = params_days[1]
      end
      if start_date == Date.today.to_s
        if Time.now.hour >= 18 
          sch_begin = start_date.to_time + 1.day
        else
          sch_begin = start_date.to_time.change(hour: Time.now.hour + 2)
        end
      else
        sch_begin = start_date.to_time 
      end
      sch_end = end_date.to_time.change(hour: 23, min: 59)

      @min_h = 7
      @max_h = 20.5
      sch_form = form_convert(sch_begin, sch_end, @min_h, @max_h)
      sch_save(sch_begin, sch_end, sch_form)

      redirect_to calendar_path
    end
  end

  private

  # bookings for comparaison
  def bookings_list
    #return Booking.where("booking_step = ? and helper_id = ? and status = ?", 2, current_user.id, "accepté").order(date: :asc, start_time: :asc)
    return Booking.where(booking_step: 2, helper_id: current_user.id)
    .where("status = ? or status = ?", "accepté", "pending")
    .order(date: :asc, start_time: :asc)
  end

  def busy_list(bookings)
    busy = []
    bookings.each do |b|
      busy << [b.date.in_time_zone("Paris"), b.hour_number]
    end
    return busy
  end

  def sch_spots(load_deploy)
    free = []
    load_deploy.each{|i| free << i}
    return free
  end

  # From Form to Schedule functions -------------------

  def form_convert_day(day, min, max)
    day_array=[]
    for h in min.step(max, 0.5) do
      day_array << h if params["#{day}#{h}"] == "1" || params["-#{day}#{h}"] == "1"
    end
    return day_array
  end

  def form_convert_schedule(sch_begin, sch_end, week)
    sch_form=[]
    week.keys.each do |d|
      for h in week[d][:array] do
        h_only = h.to_i
        h.to_s.end_with?(".0") ? h_min = 0 : h_min = 30
        schedule = IceCube::Schedule.new(start = sch_begin) do |s|
          s.add_recurrence_rule IceCube::Rule.daily
          .day(week[d][:eng].to_sym)
          .hour_of_day(h_only)
          .minute_of_hour(h_min)
          .second_of_minute(0)
        end
        for o in schedule.occurrences(sch_end) do
        sch_form << o
        end
      end
    end
    return sch_form.sort
  end

  def form_convert(sch_begin, sch_end, min, max)
    week = {
      Lundi: {array: [], eng: "monday"},
      Mardi: {array: [], eng: "tuesday"},
      Mercredi: {array: [], eng: "wednesday"},
      Jeudi: {array: [], eng: "thursday"},
      Vendredi: {array: [], eng: "friday"},
      #Samedi: {array: [], eng: "saturday"},
      #Dimanche: {array: [], eng: "sunday"},
    }
    week.keys.map do |d|
      week[d][:array]=form_convert_day(d.to_s, min, max)
    end
    sch_form = form_convert_schedule(sch_begin, sch_end, week)
    return sch_form
  end

  # Schedule LOAD functions -------------------

  def sch_extraction(type = "usual")
    return Schedule.where(user: current_user, sch_type: type)
  end

  def load_convert(sch_db)
    sch_deploy = []
    sch_db.each do |s| sch_deploy += s.occurrences.map{|o|o.to_time} end
    return sch_deploy
  end

  def sch_load(type = "usual") # not for save, read only
    return load_convert(sch_extraction(type)).sort
  end

  # Schedule SAVE functions -------------------

  def sch_merge(sch_begin, sch_end, schedule, sch_old)
    sch_new = []
    sch_old.each do |i| sch_new << i if i > sch_end || i < sch_begin end
    sch_merge = sch_new + schedule
    return sch_merge.sort
  end

  def sch_empty(old, start, finish)
    sch_hash={}
    if old.empty? || old.first >= start
      year_step = start.year
      month_step = start.month
    else
      year_step = old.first.year
      month_step = old.first.month
    end
    if old.empty? || old.last <= finish
      year_end = finish.year
      month_end = finish.month
    else
      year_end = old.last.year
      month_end = old.last.month
    end
    sch_hash[year_step.to_s] = {month_step.to_s => []}
    until year_step == year_end && month_step == month_end
      if month_step == 12
        month_step = 1
        year_step += 1
      else
        month_step += 1
      end
      if sch_hash[year_step.to_s].nil?
        sch_hash[year_step.to_s] = {month_step.to_s => []}
      else
        sch_hash[year_step.to_s][month_step.to_s] = []
      end
    end
    return sch_hash
  end

  def sch_save(sch_begin, sch_end, schedule, sch_type = "usual")
    # load & merge to obtain the new schedule
    sch_db = sch_extraction(sch_type)
    sch_old = load_convert(sch_db)
    sch_full = sch_merge(sch_begin, sch_end, schedule, sch_old)

    # Sort by year and month
    sch_hash = sch_empty(sch_old, sch_begin, sch_end)
    for o in sch_full do
      if sch_hash[o.year.to_s][o.month.to_s].nil?
        sch_hash[o.year.to_s][o.month.to_s] = [o]
      else
        list = sch_hash[o.year.to_s][o.month.to_s].push(o)
        sch_hash[o.year.to_s][o.month.to_s] = list
      end
    end

    # Save or Update
    sch_hash.keys.each do |y|
      sch_hash[y].keys.each do |m|
        if sch_db.find_by(user: current_user, year: y, month: m, sch_type: sch_type).nil?
          sch = Schedule.create(
            user: current_user,
            year: y.to_i,
            month: m.to_i,
            sch_type: sch_type,
            occurrences: sch_hash[y][m].map{|o|o.to_s},
          )
          #sch_hash[y][m].each do |o| sch.occurrences << o.to_s end
          sch.save
        else
          sch = sch_db.find_by(user: current_user, year: y, month: m, sch_type: sch_type)
          sch.update(occurrences:sch_hash[y][m].map{|o|o.to_s})
        end
      end
    end
  end

  # calendar data start
  def day_format_string(day_in)
    day_in.month < 10 ? month = "0#{day_in.month}" : month = "#{day_in.month}"
    day_in.day < 10 ? day = "0#{day_in.day}" : day = "#{day_in.day}"
    return "#{day_in.year}-" + month + "-" + day
  end

  def weekly(date)
    date.cweek < 10 ? week = "0#{date.cweek}" : week = "#{date.cweek}"
    return week
  end

  def calendrier(data_list)
    if data_list.empty?
      start_sch = Date.today
      start_date = start_sch
      until "#{start_sch.year}-#{weekly(start_sch)}" != "#{(start_date - 1.day).year}-#{weekly(start_date - 1.day)}"
        start_date -= 1.day
      end
      end_sch = Date.today
      end_date = start_sch
      until "#{end_sch.year}-#{weekly(end_sch)}" != "#{(end_date + 1.day).year}-#{weekly(end_date + 1.day)}"
        end_date += 1.day
      end
    else
      start_sch_data = data_list[data_list.keys.sort[0]].keys.sort[0].to_date
      start_sch_data > Date.today ? start_sch = Date.today : start_sch = start_sch_data
      start_date = start_sch
      until "#{start_sch.year}-#{weekly(start_sch)}" != "#{(start_date - 1.day).year}-#{weekly(start_date - 1.day)}"
        start_date -= 1.day
      end
      end_sch_data = data_list[data_list.keys.sort[-1]].keys.sort[-1].to_date
      end_sch_data < Date.today ? end_sch = Date.today : end_sch = end_sch_data
      end_date = end_sch
      until "#{end_sch.year}-#{weekly(end_sch)}" != "#{(end_date + 1.day).year}-#{weekly(end_date + 1.day)}"
        end_date += 1.day
      end
    end
    
    schedule = IceCube::Schedule.new(start = start_date, :end_time => end_date) do |s| # 
      s.add_recurrence_rule IceCube::Rule.daily
      .hour_of_day(0)
      .minute_of_hour(0)
      .second_of_minute(0)
    end
    schedule_classed = {}
    schedule.occurrences(end_date).each do |day|
      key="#{day.year}-#{weekly(day.to_date)}"
      if schedule_classed[key].nil?
        schedule_classed[key] = [day_format_string(day)]
      else
        schedule_classed[key] << day_format_string(day)
      end
    end
    return schedule_classed
  end

  def list_filling(data, name)
    l = {}
    data.each do |sch|
      if sch.class == Array
        first_key_a = "#{sch[0].to_date.year}-#{weekly(sch[0].to_date)}"
        sch[0].min == 0 ? hour_min = sch[0].hour.to_f : hour_min = sch[0].hour + 0.5
        if l[first_key_a] == nil
          l[first_key_a] = { "#{sch[0].to_date}" => {name => [[hour_min, sch[1]]]} }
        else
          if l[first_key_a]["#{sch[0].to_date}"] == nil
            l[first_key_a]["#{sch[0].to_date}"] = {name => [[hour_min, sch[1]]]}
          else
            l[first_key_a]["#{sch[0].to_date}"][name] << [hour_min, sch[1]]
          end
        end
      else
        first_key_s = "#{sch.to_date.year}-#{weekly(sch.to_date)}"
        sch.min == 0 ? hour_min = sch.hour.to_f : hour_min = sch.hour + 0.5
        if l[first_key_s] == nil
          l[first_key_s] = { "#{sch.to_date}" => {name => [hour_min]}}
        else
          if l[first_key_s]["#{sch.to_date}"] == nil
            l[first_key_s]["#{sch.to_date}"] = {name => [hour_min]}
          else
            l[first_key_s]["#{sch.to_date}"][name] << hour_min
          end
        end
      end
    end
    return l
  end

  def data_hashes(busy, free)
    list_free = list_filling(free, "free")
    list_busy = list_filling(busy, "busy")
    list = {}
    keys_list_week = (list_free.keys | list_busy.keys)
    keys_list_week.each do |key_week|
      if list_free[key_week] == nil
        list[key_week] = list_busy[key_week]
      elsif list_busy[key_week] == nil
        list[key_week] = list_free[key_week]
      else
        keys_list_days = (list_free[key_week].keys | list_busy[key_week].keys)
        list[key_week] = {}
        keys_list_days.each do |key_day|
          if list_free[key_week][key_day] == nil
            list[key_week][key_day] = list_busy[key_week][key_day]
          elsif list_busy[key_week][key_day] == nil
            list[key_week][key_day] = list_free[key_week][key_day]
          else
            list[key_week][key_day] = list_free[key_week][key_day].merge(list_busy[key_week][key_day])
          end
        end
      end
    end
    return list
  end
end
