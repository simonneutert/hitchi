// $(document).on('turbolinks:load', function() {
//   if (!($(".userarea").length > 0)) {
//   return;
// } else {
// (function current_user_check() {
//   $.ajax({
//     url: '/logincheck.json',
//     success: function(data) {
//       oldData(data);
//     },
//     complete: function() {
//       // Schedule the next request when the current one's complete
//       setTimeout(current_user_check, 2500);
//     }
//   });
// })();
// var dataArray = ["checker"];
// var i = 0;
// function oldData(data) {
//   dataArray.unshift(data);
//   i++;
//   if (i >= 3) {
//     dataArray.pop();
//   }
//   if ((dataArray.length >= 2) && (dataArray[0] == false) && (dataArray[1] == true)){
//     location.reload(true);
//   }
// }
// }});
