# $(document).on 'turbolinks:load', ->
#     return unless $(".userarea").length > 0
#     dataArray = ["checker"]
#     i = 0
#     oldData = (data) ->
#         dataArray.unshift(data)
#         i++
#         dataArray.pop() if (i >= 3)
#         location.reload(true) if ((dataArray.length >= 2) && (dataArray[0] == false) && (dataArray[1] == true))
#     current_user_check = ->
#         $.ajax '/logincheck.json',
#             success: (data) ->
#                 oldData(data)
#             complete: ->
#                 # Schedule the next request when the current one's complete
#                 setTimeout ->
#                   current_user_check()
#                 , 15000
#     current_user_check()
