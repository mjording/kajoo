// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

//cached user location - XXX TODO retrieve from cookie, encode securely
var user_lat;
var user_lon;
var user_address;
var user_location_updated = 0;
var user_location_delay = 2000000;//1000 * 60 * 60; // 1 hour, in milliseconds
var exdays = 1; //location cookie expiry

$(document).ready(function(){

  //clearinginput on report form elements  
  $('.report input:text').clearingInput();
  $('.report textarea').clearingInput();
  
  //fade out alerts  
  $('#notices').delay(2000).slideUp(1000);
  
  user_lat = getCookie('lat');
  user_lon = getCookie('lon');
  user_address = getCookie('address');
  user_location_updated = getCookie('location_updated');
  
  updateUserLocation();
});

$.fn.animateHighlight = function(highlightColor, duration) {
  var highlightBg = highlightColor || "#FFFF9C";
  var animateMs = duration || 1500;
  var originalBg = this.css("backgroundColor");
  this.stop().css("background-color", highlightBg).animate({backgroundColor: originalBg}, animateMs);
};

function updateUserLocation(force) {
  var lastupdated = getUserLocationUpdated();
  var threshold = new Date().getTime() - user_location_delay;
  
  //alert('compare '+lastupdated+' to '+threshold+' = '+(threshold-lastupdated));
  
  
  if((getUserLocationUpdated() < new Date().getTime() - user_location_delay) || force) {
    
    if(geo_position_js.init())
  	{
  		$('#location').html("<img src=\"/images/spinner.gif\"/>");
  		geo_position_js.getCurrentPosition(setUserLocation,userLocationError);//{enableHighAccuracy:true}
  	}
  	else
  	{
  		$('#location').html("Automatic Location not available");
  	}
  	
  	//we need to update this anyway so that it doesn't try to get location on _every_ page load.
  	
  	setUserLocationUpdated(new Date().getTime());
  } else {
    showUserLocation(getUserLat(), getUserLon());
    showUserAddress(getUserAddress());
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

  var lat = p.coords.latitude;
  var lon = p.coords.longitude;
  
  var pos=new google.maps.LatLng(lat,lon);

  showUserLocation(lat, lon);

  //Geocode to address. Oh yes.
  geocoder = new google.maps.Geocoder();
  geocoder.geocode({'latLng': pos}, function(results, status) {
    if (status == google.maps.GeocoderStatus.OK) {
      var address = results[1].formatted_address;
      showUserAddress(address);
      
//      setCookie('address', address);
//      setCookie('address_updated', new Date().getTime());
      var addr_param = {address: address};
      //ping server
      $.ajax({
        url: '/user/address',
        async: true,
        data: addr_param,
        dataType: 'script',
        complete: function( res, status ) {
          //alert("set location");
        }
      });
    }
  });	
  
/*
  setCookie('long', user_lon);
  setCookie('lat', user_lat);
  setCookie('location_updated', new Date().getTime());
*/
  
  var loc = {lat: lat, lon: lon}; // lat, lon
  //ping server
  $.ajax({
    url: '/user/location',
    async: true,
    data: loc,
    dataType: 'script',
    complete: function( res, status ) {
      //alert("set location");
    }
  });
  setUserLocationUpdated(new Date().getTime());
}

function showUserAddress(address) {
  $('#location').html(locationLabel(address));
}

function showUserLocation(lat, lon) {
  $('#location').html(locationLabel(lat+','+lon));
}

function locationLabel(msg) {
  return '<img src="/images/globe.png" alt="'+msg+'" width="20" height="20"/>';
}

function userLocationError() {
  $('#location').html("Err");
}

function getUserLat() {
  return user_lat;
}

function getUserLon() {
  return user_lon;
}

function getUserAddress() {
  return user_address;
}

//ms since 1/1/1970
function getUserLocationUpdated() {
  return user_location_updated;
}

function setUserLocationUpdated(time) {
  user_location_updated = time;
}

function setUserLat(lat) {
  user_lat = lat;
}

function setUserLon(lon) {
  user_lon = lon;
}

function setUserAddress(address) {
  user_address = address;
}

function getCookie(c_name)
{
  var i,x,y,ARRcookies=document.cookie.split(";");
  for (i=0;i<ARRcookies.length;i++) {
    x=ARRcookies[i].substr(0,ARRcookies[i].indexOf("="));
    y=ARRcookies[i].substr(ARRcookies[i].indexOf("=")+1);
    x=x.replace(/^\s+|\s+$/g,"");
    if (x==c_name) {
      return unescape(y);
    }
  }
}

function setCookie(c_name,value,exdays)
{
  var exdate=new Date();
  exdate.setDate(exdate.getDate() + exdays);
  var c_value=escape(value) + ((exdays==null) ? "" : "; expires="+exdate.toUTCString());
  document.cookie=c_name + "=" + c_value;
}