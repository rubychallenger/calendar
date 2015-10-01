$ ->
  $(".highlight").click ->
    $('.' + $(this).parent().parent().attr('class').split(' ').shift()).toggleClass("highlighted")
    $('.' + $(this).parent().parent().attr('class').split(' ').shift()).children().children(".highlight").toggleClass("fi-plus").toggleClass("fi-minus")
    $('.' + $(this).parent().parent().attr('class').split(' ').shift() + 'rec').toggleClass("shadow")

  $(".timezone").click ->
    $(".timezoneselect").slideDown()
    $(this).hide()