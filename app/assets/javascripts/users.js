// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.


$(document).on('turbolinks:load', function() {

  // make rows in the users table clickable
  $('#users .clickable-row').off('click').on('click', function() {
    console.log('clicked');
    window.document.location = $(this).data('href');
  });
});