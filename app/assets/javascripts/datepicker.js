window.setupDatePicker = function(id) {
  $(id + ' .fa-calendar').flatpickr({
    mode: "range",
    onChange: function(selectedDates, dateStr, instance){
      const dates = selectedDates.map(date => this.formatDate(date, "Y-m-d"));
      $(id + ' #trip_started_at').val(dates[0]);
      $(id + ' #trip_ended_at').val(dates[1]);
    },
  });
};
