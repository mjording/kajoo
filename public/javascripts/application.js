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
  
  $('#notices').delay(2000).slideUp(1000);
//  $('#flash_alert').delay(2000).slideUp(1000);
  
  //fixed positioning for iPhone
  //$(window).bind( "scroll", maybeShowNavBar );
});

$.fn.animateHighlight = function(highlightColor, duration) {
  var highlightBg = highlightColor || "#FFFF9C";
  var animateMs = duration || 1500;
  var originalBg = this.css("backgroundColor");
  this.stop().css("background-color", highlightBg).animate({backgroundColor: originalBg}, animateMs);
};

function showNavBar() {
 var win_y = $(window).height();
 var scroll_y = $(window).scrollTop();
 $("footer").css({ top: ((win_y - 36) + scroll_y) + "px" });
 $("header").css({ top: scroll_y + "px" });
}

var showTimer = false;

function maybeShowNavBar(evt) {
 if ( showTimer ) {
   clearTimeout( showTimer );
 }
 showTimer = setTimeout( showNavBar, 175 );
}

/**
 * extend jquery with "$('elem').scrollToMe();
 */
$(function($){
	$.fn.scrollToMe = function(){
		$('html,body').animate({
			scrollTo: this.offset().top
		}, 'fast');
	}
})(jQuery);
