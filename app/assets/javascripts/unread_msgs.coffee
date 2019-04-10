# Reading the data from /message_counter.json
# then filling the span in the navigation
# in a setTimeout method
$(document).on 'turbolinks:load', ->
    return unless $(".userarea").length > 0
    unreadmsgs = ->
        $.ajax '/message_counter.json',
            success: (data) ->
                if data >= 1
                    $('.message_counter').html(" (" + data + " neu)")
                    $(".msgmenu").addClass("highlightlink")
                    $('.newmsgrefresh').fadeIn()
            complete: ->
                # Schedule the next request when the current one's complete
                setTimeout ->
                    unreadmsgs()
                , 30000
    unreadmsgs()
