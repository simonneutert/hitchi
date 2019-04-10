$(document).on 'turbolinks:load', ->
  return unless $(".home.login").length > 0
  $("#acceptbutton").show()
  $("#acceptbutton").click ->
    $("#acceptbutton").hide() $("#facebookloginbutton").fadeIn() $('<p><a class="btn btn-danger btn-lg btn-block" href="/hitchiwas#wiesonurfb"><small>Wieso nur Facebook-Login?!</small></a></p>').insertAfter(".row")
