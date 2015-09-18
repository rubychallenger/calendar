class CalendarController < ApplicationController
before_action :time_zone_set

  def nil.split *args
    nil # splitting of nil, in any imaginable way, can only result again in nil
  end

  def nil.include? *args
    false
  end

  def calendar
    @eps = []
    (1..31).each do |index|
        @eps[index] = Episode.all.map { |ep| ep if ep.airdate.month == Time.now.month and ep.airdate.day == index }
        @eps[index].delete(nil)
    end

    @recent = Episode.all.order(:airdate).last(4).reverse
  end

  def select_time_zone
    respond_to do |format|
        format.html {
            cookies[:time_zone] = params[:person][:time_zone]
            Time.zone = params[:person][:time_zone]
            redirect_to calendar_path
        }

        format.js
    end
  end

  def set_cookies
    arr = cookies[:highlight].split(',') if cookies[:highlight]
    if arr.include?(params[:name])
      arr.delete(params[:name])
    else
      arr << params[:name]
    end
    cookies[:highlight] = (arr.class == Array) ? arr.join(',') : ''
    redirect_to '/calendar'
  end
  
  protected

  def time_zone_set
    Time.zone = cookies[:time_zone] if cookies[:time_zone]
  end
end
