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
		date = DateTime.strptime("#{@day}-#{@month}-#{@year}","%d-%m-%Y")+int.days
		{year: date.year, month: date.month, day: date.day, wday: date.strftime("%w")}
	end

	def set_background(index)
		if index % 2 == 0
			"background-color: #343434"
		else
			"background-color: #292929"
		end 
	end
end
