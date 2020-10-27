class CalendarsController < ApplicationController
  def show
    @sch_begin = Time.now
    @sch_end = @sch_begin + 3600 * 24 * 60
    @sch_duration = @sch_begin + 3600
    hour = 10
    @schedule = IceCube::Schedule.new(start = @sch_begin) do |s| # , :end_time => @sch_duration
      s.add_recurrence_rule IceCube::Rule.daily.day(:friday).hour_of_day(hour).minute_of_hour(0).second_of_minute(0)
    end
    @schedule_rule = @schedule
    @schedule_days = @schedule.occurrences(@sch_end)

    #warning: si on met @schedule_days_2 = @schedule_days,
    #modifier @schedule_days_2 modifie @schedule_days ...

    @load = sch_extraction
    @load_deploy = load_convert(@load)
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

    #binding.pry
    redirect_to sch_form_path
  end

  private

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
    for d in week do
      for h in d[0] do
        schedule = IceCube::Schedule.new(start = sch_begin) do |s|
          s.add_recurrence_rule IceCube::Rule.daily.day(d[2].to_sym).hour_of_day(h).minute_of_hour(0).second_of_minute(0)
        end
        for o in schedule.occurrences(sch_end) do
        sch_form << o
        end
      end
    end
    return sch_form.sort
  end

  def form_convert(sch_begin, sch_end)
    week=[[[],"lundi","monday"],[[],"mardi","tuesday"],[[],"mercredi","wednesday"],
    [[],"jeudi","thursday"],[[],"vendredi","friday"]]
    for d in week do
      d[0]=form_convert_day(d[1])
    end
    sch_form = form_convert_schedule(sch_begin, sch_end, week)
    return sch_form
  end

  # Schedule LOAD functions -------------------

  def sch_extraction
    # users = User.where(name: 'David', occupation: 'Code Artist').order(created_at: :desc)
    # user_id: current_user.id ou user:current_user
    return Schedule.where(user:current_user)
  end

  def load_convert(sch_db)
    sch_deploy = []
    sch_db.each do |s| sch_deploy += s.occurrences.map{|o|o.to_time} end
    return sch_deploy
  end

  def sch_load # not for save, read only
    #sch_db = sch_extraction
    #return load_convert(sch_db)
  end

  # Schedule SAVE functions -------------------

  def sch_merge(sch_begin, sch_end, schedule, sch_old)
    sch_new = []
    sch_old.each do |i| sch_new << i if i > sch_end || i < sch_begin end
    binding.pry
    return sch_new + schedule
  end

  def sch_save(sch_begin, sch_end, schedule)
    sch_db = sch_extraction
    sch_old = load_convert(sch_db)
    sch_full = sch_merge(sch_begin, sch_end, schedule, sch_old)
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
    #return sch_hash #temp for test
    sch_hash.keys.each do |y|
      sch_hash[y].keys.each do |m|
        # save schedule:sch_hash[y][m] year:y.to_i month:m.to_i user:current_user
        if sch_db.find_by(user:current_user, year:y, month:m).nil?
          sch = Schedule.create(user:current_user, year:y.to_i, month:m.to_i, occurrences:sch_hash[y][m].map{|o|o.to_s})
          #sch_hash[y][m].each do |o| sch.occurrences << o.to_s end
          sch.save
        else
          sch = sch_db.find_by(user:current_user, year:y, month:m)
          sch.update(occurrences:sch_hash[y][m].map{|o|o.to_s})
        end
      end
    end
  end

end
