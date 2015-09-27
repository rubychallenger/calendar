$ ->
  $(".btnreveal").click ->
    $(".loginscr").show()
    $("input[type=text], textarea").val("");
    $("input[type=password], textarea").val("");

  $(".bod").click ->
    $(".loginscr").hide()
