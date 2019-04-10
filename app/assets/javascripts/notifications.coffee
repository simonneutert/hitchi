$(document).on 'turbolinks:load', ->
    $(".error-click").click ->
        $(@).hide()
    $(".notice").click ->
        $(@).hide()
    $("#notice").click ->
        $(@).hide()
