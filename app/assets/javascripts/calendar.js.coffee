week = ["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]

days_in_month = (month,year) ->
  return new Date(year, month, 0).getDate();


$ ->
  $(".highlight").click ->
    $('.' + $(this).parent().parent().attr('class').split(' ').shift()).toggleClass("highlighted")
    $('.' + $(this).parent().parent().attr('class').split(' ').shift()).children().children(".highlight").toggleClass("fi-plus").toggleClass("fi-minus")
    $('.' + $(this).parent().parent().attr('class').split(' ').shift() + 'rec').toggleClass("shadow")

  $(".timezone").click ->
    $(".timezoneselect").slideDown()
    $(this).hide()

  $(".day").click ->
    $this = $(this)
    wday = $('#wday').html()
    day = parseInt($this.attr('class').split(' ').pop())
    year = parseInt($('#setdate').val().split('-')[0])
    month = parseInt($('#setdate').val().split('-')[1])

    $('.day').removeClass(String(day))
    $('.' + String(day)).hide()
    dat1 = null
    dat2 = null
   
    if $this.hasClass('next')
      if (day+1) <= days_in_month(month,year)
        $('#wday').html(week[($.inArray(wday,week)+1) % 7])
        $('#day').html(String(day+1))
        $('.' + String(day+1)).show()
        $('.day').addClass(String(day+1))
      else
        dat2 = new Date(year,month-1,days_in_month(month,year))
        dat2.setDate(dat2.getDate()+1)
        window.location.href = '/calendar?month='+String(dat2.getMonth()+1)+'&year='+String(dat2.getFullYear())

    if $this.hasClass('prev')
      if (day-1) != 0
        $('#wday').html(week[($.inArray(wday,week)-1) % 7])
        $('#day').html(String(day-1))
        $('.' + String(day-1)).show()
        $('.day').addClass(String(day-1))
      else
        dat1 = new Date(year,month-1,1)
        dat1.setDate(dat1.getDate()-1)
        window.location.href = '/calendar?month='+String(dat1.getMonth()+1)+'&year='+String(dat1.getFullYear())+'&day='+String(dat1.getDate())
      
   