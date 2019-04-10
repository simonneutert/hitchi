# navigation click on the hamburger
$(document).on 'turbolinks:load', ->
  $(".menu-hamburger").click ->
    $(".menu-status").toggle()
