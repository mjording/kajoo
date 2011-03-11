// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(document).ready(function(){

  //bounce down report form
  //$('#create-report-link').bind('click', function() {  
      //alert('Unobtrusive!');  
      //return false;
  //});
  
  //ajax submit report form
  
  //clearinginput on report form elements
  
  $('.report input:text').clearingInput();
  $('.report textarea').clearingInput();
  
  //fade out alerts
  
  $('p.alert').delay(2000).slideUp(1000);
  $('p.notice').delay(2000).slideUp(1000);
  
});

$.fn.animateHighlight = function(highlightColor, duration) {
  var highlightBg = highlightColor || "#FFFF9C";
  var animateMs = duration || 1500;
  var originalBg = this.css("backgroundColor");
  this.stop().css("background-color", highlightBg).animate({backgroundColor: originalBg}, animateMs);
};