namespace = (target, name, block) ->
  [target, name, block] = [(if typeof exports isnt 'undefined' then exports else window), arguments...] if arguments.length < 3
  top    = target
  target = target[item] or= {} for item in name.split '.'
  block target, top

footerfitter = ->
  contentheight = $(window).height()
  htmlcontent = $(".content").height()
  navheight = $(".menu").height()
  footerheight = $("footer").height()
  if contentheight > 667 && contentheight > htmlcontent
    $("footer").css
      marginTop: (contentheight - htmlcontent - 2 * navheight)
  else
    $("footer").css("margin-top", "")

namespace 'FooterPlacement', (exports) ->
  exports.footerfitter = ->
    footerfitter

$(window).resize ->
  footerfitter()

$(document).on 'turbolinks:load', ->
  footerfitter()
