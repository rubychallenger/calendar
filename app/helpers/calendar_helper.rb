module CalendarHelper
    def set_year_next
        (@month == 12) ? (@year + 1) : @year
    end

    def set_month_next
        (@month == 12) ? 1 : (@month + 1)
    end

    def set_year_prev
        (@month == 1) ? (@year - 1) : @year
    end

    def set_month_prev
        (@month == 1) ? 12 : (@month - 1)
    end

    def move_day int
        unless (Time.now.month == DateTime.strptime("#{@day}-#{@month}-#{@year}","%d-%m-%Y").month)
            date = DateTime.strptime("#{@day}-#{@month}-#{@year}","%d-%m-%Y")+int.days
            calendar_path({year: date.year, month: date.month, day: date.day, wday: date.strftime("%w")})
        else
            '#'
        end
    end

    def set_background(index)
        if index % 2 == 0
            "background-color: #343434"
        else
            "background-color: #292929"
        end 
    end

    def mobile_device?
        if session[:mobile_param]
         session[:mobile_param] == "1"
        else
         request.user_agent =~ /Mobile|webOS/
        end
    end

end
