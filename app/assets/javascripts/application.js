//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require jquery3
//= require popper
//= require bootstrap
//= require flatpickr
//= require chosen-jquery
//= require_tree .

$(document).ready(function(){
  hideAlert();

  window.setupCountriesSelect();
  window.setupDatePicker('#new_trip');
});
