# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
init_form_new = ->
    $(".seekpart").hide()
    $(".offerpart").hide()
    $("#offer_seek").attr('value', false)
    $("#makeoffer").removeClass("btn-active").addClass("btn-passive")
    $(".new_offer").hide()
    FooterPlacement.footerfitter()()
make_offer_select = ->
    $(".new_offer").show()
    $(".seekpart").hide()
    $(".offerpart").show()
    $("#makeoffer").removeClass("btn-passive").addClass("btn-active")
    $("#makeseek").removeClass("btn-active").addClass("btn-passive")
    # change the value of the hidden_field for :seek params
    $("#offer_seek").attr('value', false)
    FooterPlacement.footerfitter()()
make_seek_select = ->
    $(".new_offer").show()
    $(".seekpart").show()
    $(".offerpart").hide()
    $("#makeseek").addClass("btn-active").removeClass("btn-passive")
    $("#makeoffer").removeClass("btn-active").addClass("btn-passive")
    # change the value of the hidden_field for :seek params
    $("#offer_seek").attr('value', true)
    FooterPlacement.footerfitter()()
$(document).on 'turbolinks:load', ->
    return unless $(".offers.new").length > 0
    init_form_new()
    $("#makeoffer").click ->
        make_offer_select()
    $("#makeseek").click ->
        make_seek_select()
$(document).on 'turbolinks:load', ->
    return unless $(".offers.edit").length > 0 || $(".offers.update").length > 0 || $(".offers.create").length > 0
    FooterPlacement.footerfitter()()
    $("#offer_rules").attr("checked", false)
    $("#makeoffer").click ->
        make_offer_select()
    $("#makeseek").click ->
        make_seek_select()
    if $("#offer_seek").val() == "true"
        $(".seekpart").show()
        $(".offerpart").hide()
        $("#makeseek").removeClass("btn-passive").addClass("btn-active")
        $("#makeoffer").removeClass("btn-active").addClass("btn-passive")
    else
        $(".seekpart").hide()
        $(".offerpart").show()
        $("#makeseek").removeClass("btn-active").addClass("btn-passive")
        $("#makeoffer").removeClass("btn-passive").addClass("btn-active")
        $("#offer_seek").attr('value', false)
