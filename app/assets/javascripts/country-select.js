window.setupCountriesSelect = function() {
  $('.country-chosen').chosen({
    multiple: true,
    width: 227,
    allowClear: true,
    no_results_text: 'No results matched'
  });
};
