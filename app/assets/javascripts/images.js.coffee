$(document).ready -> 
  h = $('.backgroundimage').height()    
  newH = $(window).height()
  B = true
  $('.drpdwn').click ->
      $('.tabs-content').toggle()
      $('.hiddenImage').slideToggle()
      if B 
      	$('.backgroundimage').height( newH )
      	B = false
      else
      	$('.backgroundimage').height( h )
      	B = true