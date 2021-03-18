class CalendarsController < ApplicationController
  def show    
    @sch_begin = Time.now
    @sch_end = @sch_begin + 3600 * 24 * 60
    @sch_duration = @sch_begin + 3600
    hour = 10
    @schedule = IceCube::Schedule.new(start = @sch_begin) do |s| # , :end_time => @sch_duration
      s.add_recurrence_rule IceCube::Rule.daily
      .day(:friday)
      .hour_of_day(hour)
      .minute_of_hour(0)
      .second_of_minute(0)
    end
    @schedule_rule = @schedule
    @schedule_days = @schedule.occurrences(@sch_end)

    #warning: si on met @schedule_days_2 = @schedule_days,
    #modifier @schedule_days_2 modifie @schedule_days ...


    @load = sch_extraction
    @load_deploy = load_convert(@load)

    @bookings = bookings_list
    @busy = busy_list(@bookings)

    @vs = vs(@load_deploy,@busy)

    @list_disponibility_classed = data_hashes(@busy, @vs)
    @calendrier = calendrier(@list_disponibility_classed)
  end

  def form
    @sch_begin = Time.now
    @sch_end = @sch_begin + 3600 * 24 * 60
  end
  
  def sch_generate
    @test = params

    @sch_begin = Time.now # later : en fct params et datepickr
    @sch_end = @sch_begin + 3600 * 24 * 60 # later : en fct params et datepickr

    sch_form=form_convert(@sch_begin, @sch_end)
    sch_save(@sch_begin, @sch_end, sch_form)

    redirect_to sch_form_path
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
      busy << [b.date.in_time_zone("Paris"), b.hour_number] # verif CET ou CEST ???
    end
    return busy
  end

  def vs(load_deploy,busy)
    free = []
    load_deploy.each{|i| free << i}
    busy.each do |b|
      for i in 0...b[1]
        free.delete(b[0] + i.hour)
      end
    end
    return free
  end

  # From Form to Schedule functions -------------------

  def form_convert_day(day)
    day_array=[]
    for h in 8..20 do
      day_array << h if params["#{day}#{h}"] == "1"
    end
    return day_array
  end

  def form_convert_schedule(sch_begin, sch_end, week)
    sch_form=[]
    week.keys.each do |d|
      for h in week[d][:array] do
        schedule = IceCube::Schedule.new(start = sch_begin) do |s|
          s.add_recurrence_rule IceCube::Rule.daily
          .day(week[d][:eng].to_sym)
          .hour_of_day(h)
          .minute_of_hour(0)
          .second_of_minute(0)
        end
        for o in schedule.occurrences(sch_end) do
        sch_form << o
        end
      end
    end
    return sch_form.sort
  end

  def form_convert(sch_begin, sch_end)
    week = {
      lundi: {array: [], eng: "monday"},
      mardi: {array: [], eng: "tuesday"},
      mercredi: {array: [], eng: "wednesday"},
      jeudi: {array: [], eng: "thursday"},
      vendredi: {array: [], eng: "friday"}
      #samedi: {array: [], eng: "saturday"}
      #dimanche: {array: [], eng: "sunday"}
    }
    week.keys.map do |d|
      week[d][:array]=form_convert_day(d.to_s)
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
    return load_convert(sch_extraction(type))
  end

  # Schedule SAVE functions -------------------

  def sch_merge(sch_begin, sch_end, schedule, sch_old)
    sch_new = []
    sch_old.each do |i| sch_new << i if i > sch_end || i < sch_begin end
    return sch_new + schedule
  end

  def sch_save(sch_begin, sch_end, schedule, sch_type = "usual")
    # load & merge to obtain the new schedule
    sch_db = sch_extraction(sch_type)
    sch_old = load_convert(sch_db)
    sch_full = sch_merge(sch_begin, sch_end, schedule, sch_old)

    # Sort by year and month
    sch_hash={}
    for o in sch_full do
      if sch_hash[o.year.to_s].nil?
        sch_hash[o.year.to_s] = {o.month.to_s => [o]}
      elsif sch_hash[o.year.to_s][o.month.to_s].nil?
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

  def calendrier(data_list)
    start_sch = data_list[data_list.keys[0]].keys[0].to_date
    start_date = start_sch
    until "#{start_sch.year}-#{start_sch.cweek}" != "#{(start_date - 1.day).year}-#{(start_date - 1.day).cweek}"
      start_date -= 1.day
    end
    start_date = start_sch
    end_sch = data_list[data_list.keys[-1]].keys[-1].to_date
    end_date = end_sch
    until "#{end_sch.year}-#{end_sch.cweek}" != "#{(end_date + 1.day).year}-#{(end_date + 1.day).cweek}"
      end_date += 1.day
    end
    schedule = IceCube::Schedule.new(start = start_date, :end_time => end_date) do |s| # 
      s.add_recurrence_rule IceCube::Rule.daily
      .hour_of_day(0)
      .minute_of_hour(0)
      .second_of_minute(0)
    end
    schedule_classed = {}
    schedule.occurrences(end_date).each do |day|
      key="#{day.year}-#{day.to_date.cweek}"
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
        first_key_a = "#{sch[0].to_date.year}-#{sch[0].to_date.cweek}"
        if l[first_key_a] == nil
          l[first_key_a] = { "#{sch[0].to_date}" => {name => [[sch[0].hour, sch[1]]]} }
        else
          if l[first_key_a]["#{sch[0].to_date}"] == nil
            l[first_key_a]["#{sch[0].to_date}"] = {name => [[sch[0].hour, sch[1]]]}
          else
            l[first_key_a]["#{sch[0].to_date}"][name] << [sch[0].hour, sch[1]]
          end
        end
      else
        first_key_s = "#{sch.to_date.year}-#{sch.to_date.cweek}"
        if l[first_key_s] == nil
          l[first_key_s] = { "#{sch.to_date}" => {name => [sch.hour]}}
        else
          if l[first_key_s]["#{sch.to_date}"] == nil
            l[first_key_s]["#{sch.to_date}"] = {name => [sch.hour]}
          else
            l[first_key_s]["#{sch.to_date}"][name] << sch.hour
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
