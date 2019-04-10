// Filtering the search hits by checking and unchecking the boxes
document.addEventListener("turbolinks:before-cache", function() {
  $(".rides").hide();
})
$(document).on('turbolinks:load', function() {
    $(".minustag").hide()
    var checkercheck = function() {
        if (document.getElementById('isdiameterdep').checked) {
            $(".isdiameterdep").show();
            $(".isdiameterdest").hide();
            $(".isdiameter").hide();
        }
        if (document.getElementById('isdiameterdest').checked) {
            $(".isdiameterdest").show();
            $(".isdiameterdep").hide();
            $(".isdiameter").hide();
        }
        if (document.getElementById('isdiameterdep').checked && document.getElementById('isdiameterdest').checked) {
            $(".isdiameterdep").show();
            $(".isdiameterdest").show();
            $(".isdiameter").show();
        }
        if (!document.getElementById('isdiameterdep').checked && !document.getElementById('isdiameterdest').checked) {
            $(".isdiameterdest").hide();
            $(".isdiameterdep").hide();
            $(".isdiameter").hide();
        }
    }

    $("#isdiameterdep").change(function() {
        checkercheck();
    })
    $("#isdiameterdest").change(function() {
        checkercheck();
    })
    $("#minustag").change(function() {
        $(".minustag").toggle();
    })
    $("#plustag").change(function() {
        $(".plustag").toggle();
    })
    $("#plusplustag").change(function() {
        $(".plusplustag").toggle();
    })
    $("#searchpanel").click(function() {
        $(".searchoptions").toggle();
    })
});
