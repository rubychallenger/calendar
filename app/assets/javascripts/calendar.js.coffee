$ ->
  $(".cal p").fitText(0.6,{minFontSize:"0.2em",maxFontSize:"16px"})
  $(".header").fitText(0.6,{minFontSize:"0.2em",maxFontSize:"40px"})
  
  $(".highlight").click ->
    $('.' + $(this).parent().parent().attr('class').split(' ').shift()).toggleClass("highlighted")
    $('.' + $(this).parent().parent().attr('class').split(' ').shift()).children(".highlight").toggleClass("fi-plus").toggleClass("fi-minus")
    $('.' + $(this).parent().parent().attr('class').split(' ').shift() + 'rec').toggleClass("shadow")

  $(".timezone").click ->
    $(".timezoneselect").slideDown()
    $(this).hide()