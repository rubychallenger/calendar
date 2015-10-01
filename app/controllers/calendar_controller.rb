class CalendarController < ApplicationController
  before_action :time_zone_set

  def nil.split *args
    nil # splitting of nil, in any imaginable way, can only result again in nil
  end

  def nil.include? *args
    false
  end

  def calendar
    i = request.remote_ip
    #i = request.env['REMOTE_ADDR']
    puts i

    v = Visitor.find_or_create_by(ip: i)
    v.update_attribute(:count, v.count + 1)

    @eps = []

    @month = params[:month].is_a?(NilClass) ? Time.now.month : params[:month].to_i
    @year = params[:year].is_a?(NilClass) ? Time.now.year : params[:year].to_i
    @day = params[:day].is_a?(NilClass) ? Time.now.day : params[:day].to_i
    @wday = params[:wday].is_a?(NilClass) ? Time.now.strftime("%w") : params[:wday].to_i

    #puts @month

    this_month_episodes = Episode.all.select {|ep| ep.airdate.month == @month and ep.airdate.year == @year }
    (1..31).each do |index|
        @eps[index] = this_month_episodes.select { |ep| ep.airdate.day == index }.sort! {|a,b| a.airdate <=> b.airdate }
        @eps[index].delete(nil)
    end

    @recent = Episode.where("airdate <= '%s' and airdate >= '%s' ",Time.now, Time.now - 1.month).order(:airdate).last(5).reverse

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
    arr = []
    arr = cookies[:highlight].split(',') if cookies[:highlight]
    if arr.include?(params[:name])
      arr.delete(params[:name])
    else
      arr << params[:name]
    end
    cookies[:highlight] = (arr.class == Array) ? arr.join(',') : ''
    redirect_to '/calendar'
  end 

  def visitor_destroy
  
  end

  protected

  def time_zone_set
    Time.zone = cookies[:time_zone] if cookies[:time_zone]
  end
end
