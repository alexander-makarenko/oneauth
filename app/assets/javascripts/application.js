// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require turbolinks
//= require_tree .

function showFlash(html) {
  $(html).insertAfter('header');
}

// make flash messages appear with a slide-down and disappear after a timeout
function animateFlash() {
  var $flash = $('.alert:not(.validation-errors):not(.important)');
  if ($flash.length)
    $flash.hide().delay(700).slideDown(150).delay(4000).slideUp(150, function() {
      $(this).remove();
    });
}

// fade out and remove any flash messages currently on-screen
function removeFlash() {
  var $flash = $('.alert:not(.validation-errors):not(.important)');
  if ($flash.length)
    $flash.stop(true).fadeOut(200, function() {
      $(this).remove();
    });
}

$(document).on('turbolinks:load', function() {
  animateFlash();

  // make rows in certain tables clickables
  $('table .clickable-row').off('click').on('click', function() {
    console.log('clicked');
    window.document.location = $(this).data('href');
  });
});