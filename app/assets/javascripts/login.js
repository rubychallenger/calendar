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

var arr = [];
$(document).ready(function() {
    $('.titlename #span').hover(function(){
        id = $(this).parent().attr('id');
       
        if ($.inArray(id,arr) != -1) {
            $('#tooltip-span').show();
            $('.'+id+"popup").show();
        } else {
        arr.push(id);
        $.ajax("show_popup/" + id);
        $('#tooltip-span').css({
            "display":"block",
            "position":"fixed",
            "overflow":"hidden"});
        }}, function() {
            if ($(".wrapp").is(":hover") == false) {
                $('#tooltip-span').children().hide();
                $('#tooltip-span').css("display","none");
            }
        });
    $('.wrapp').mouseleave(function() {
        $('#tooltip-span').children().hide();
        $('#tooltip-span').css("display","none");
    })
});
