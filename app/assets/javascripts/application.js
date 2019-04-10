// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require jquery3
//= require popper
//= require bootstrap
//= require flatpickr
//= require_tree .

$(document).ready(function(){
  $("#new_trip #trip_started_at").prop('disabled', true);
  $("#new_trip #trip_ended_at").prop('disabled', true);

  $('#new_trip .fa-calendar').flatpickr({
    mode: "range",
    onChange: function(selectedDates, dateStr, instance){
      $("#new_trip #trip_started_at").prop('disabled', false);
      $("#new_trip #trip_ended_at").prop('disabled', false);
      const dates = selectedDates.map(date => this.formatDate(date, "Y-m-d"));
      $('#new_trip #trip_started_at').val(dates[0]);
      $('#new_trip #trip_ended_at').val(dates[1]);
    },
  });
});
