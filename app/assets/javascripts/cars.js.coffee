# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
#
$("#search_cars input").change(function (e) {
  $("#search_form").submit();
});

