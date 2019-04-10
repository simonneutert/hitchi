/*
* Reading the data from /message_counter.json
* then filling the span in the navigation
* in a setTimeout method
*/
// $(document).on('turbolinks:load', function() {
//   if (!($(".userarea").length > 0)) {
//   return;
// } else {
// (function unreadmsgs() {
//   $.ajax({
//     url: '/message_counter.json',
//     success: function(data) {
//       if (data >= 1) {
//         $('.message_counter').html(" (" + data + " neu)");
//         $(".msgmenu").addClass("highlightlink");
//         $('.newmsgrefresh').fadeIn();
//       }
//     },
//     complete: function() {
//       // Schedule the next request when the current one's complete
//       setTimeout(unreadmsgs, 15000);
//     }
//   });
// })();
// }});
