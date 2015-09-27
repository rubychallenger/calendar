String.prototype.capital = function() {
    return this.charAt(0).toUpperCase() + this.slice(1);
}

$(document).on('submit', '#login_form , #form', function(e) {
}).on('ajax:success', '#login_form, #form', function(e, data, status, xhr) {
    location.reload(true);
}).on('ajax:error', '#login_form, #form', function(e, data, status, xhr) {
    $(".error").show().text(data["responseText"].replace(/[^A-Za-z\s\:\']+/g, '').replace(':',' ').capital() );
    $("input[type=text], textarea").val("");
    $("input[type=password], textarea").val("");
});

$(document).ready(function() {
    $('.titlename span').hover(function(){ 
                $.ajax("show_popup/" + $(this).parent().attr('id'));
                $('#tooltip-span').css({
                    "display":"block",
                    "position":"fixed",
                    "overflow":"hidden"})
        }, function() {
            if ($(".wrap").is(":hover") == false) {
                $('#tooltip-span').css("display","none");
            }
        });
    $('.wrap').mouseleave(function() {
        $('#tooltip-span').css("display","none");
    })
});
