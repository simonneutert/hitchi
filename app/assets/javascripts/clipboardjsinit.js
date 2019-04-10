$(document).on('turbolinks:load', function() {
  var btns = document.querySelectorAll('.copybtn');
  for (var i = 0; i < btns.length; i++) {
      btns[i].addEventListener('mouseleave', function(e) {
          e.currentTarget.setAttribute('class', 'copybtn');
          e.currentTarget.removeAttribute('aria-label');
      });
  }
  var clip = new Clipboard('.copybtn');
  clip.on('success', function(e) {
      e.clearSelection();
      showTooltip(e.trigger, "kopiert!");
  });
  clip.on('error', function(e) {
      showTooltip(e.trigger, fallbackMessage(e.action));
  });
  var btnsSmall = document.querySelectorAll('.copybtnsmall');
  for (var i = 0; i < btnsSmall.length; i++) {
      btnsSmall[i].addEventListener('mouseleave', function(e) {
          e.currentTarget.setAttribute('class', 'copybtnsmall');
          e.currentTarget.removeAttribute('aria-label');
      });
  }
  var clipSmall = new Clipboard('.copybtnsmall');
  clipSmall.on('success', function(e) {
      e.clearSelection();
      showTooltip(e.trigger, "kopiert!");
  });
  clipSmall.on('error', function(e) {
      showTooltip(e.trigger, fallbackMessage(e.action));
  });
});
