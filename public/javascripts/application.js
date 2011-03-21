// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

//cached user location - XXX TODO retrieve from cookie
var user_lat;
var user_lon;
var user_address;
var user_location_updated = 0;
var user_location_delay = 0;//1000 * 60 * 60; // 1 hour, in milliseconds

$(document).ready(function(){

  //clearinginput on report form elements  
  $('.report input:text').clearingInput();
  $('.report textarea').clearingInput();
  
  //fade out alerts  
  $('#notices').delay(2000).slideUp(1000);
  
  updateUserLocation();
});

$.fn.animateHighlight = function(highlightColor, duration) {
  var highlightBg = highlightColor || "#FFFF9C";
  var animateMs = duration || 1500;
  var originalBg = this.css("backgroundColor");
  this.stop().css("background-color", highlightBg).animate({backgroundColor: originalBg}, animateMs);
};

function updateUserLocation() {
  if(user_location_updated < 1000 - user_location_delay) {
    
    if(geo_position_js.init())
  	{
  		$('#location').html("<img src=\"/images/spinner.gif\"/>");
  		/*
if(Modernizr.webworkers) {
  		  var geoWorker = new Worker('/javascripts/workers/geolocate.js');
  		  
  		  geoWorker.addEventListener('message', function(event) {
  		    var values = event.data;
  		    
  		    //alert(values);
  		    
  		    if(values['alert']) {
  		      alert('from worker: '+values['alert']);
  		    }
  		    
  		    if(values['address']) {
  		      $('#location').html(values['address']);
  		    }
  		    
  		    if(values['lat'] && values['lon']) {
  		      user_lat = values['lat']; user_lon = values['lon'];
  		      $('#location').html(user_lat+','+user_lon);
  		    }
  		  });
  		  
  		  geoWorker.addEventListener('error', function(event) {
  		    alert(event.data);
  		  });
  		  
  		  geoWorker.postMessage();//geo_position_js.getCurrentPosition
  		  
  		} else {
*/
  		  geo_position_js.getCurrentPosition(setUserLocation,function(){$('#location').html("Couldn't get location")},{enableHighAccuracy:true});
  		/*}*/
  	}
  	else
  	{
  		$('#location').html("Automatic Location not available");
  	}
  }
}

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
(function($) {
  //$(function() {

	$.fn.scrollToMe = function(){
		$('html,body').animate({
			scrollTo: this.offset().top
		}, 'fast');
	}
})(jQuery);

//callback from geo.js
function setUserLocation(p)
{

  var user_lat = p.coords.latitude;
  var user_lon = p.coords.longitude;
  
  var pos=new google.maps.LatLng(user_lat,user_lon);

  $('#location').html(user_lat+','+user_lon);

  //Geocode to address. Oh yes.
  geocoder = new google.maps.Geocoder();
  geocoder.geocode({'latLng': pos}, function(results, status) {
    if (status == google.maps.GeocoderStatus.OK) {
      var address = results[1].formatted_address;
      $('#location').html(address);
    }
  });	
  
  var loc = {lat: user_lat, lon: user_lon}; // lat, lon
  $.ajax({
    url: '/user/location',
    async: true,
    data: loc,
    dataType: 'script',
    complete: function( res, status ) {
      //alert("set location");
    }
  });
  user_location_updated = 1000;//getTime();
}

