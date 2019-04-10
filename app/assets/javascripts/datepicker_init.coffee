# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on 'turbolinks:load', ->
    return unless $(".datepicker").length > 0
    $('.datepicker').datepicker
        format: "dd.mm.yyyy",
        daysOfWeekHighlighted: "6,0"
        weekStart: 1,
        maxViewMode: 2,
        todayBtn: true,
        language: "de",
        todayHighlight: true,
        autoclose: true
