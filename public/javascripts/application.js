Kajoo = (function (jQuery) {

  var Location = (function () {

    //cached user location - XXX TODO retrieve from cookie, encode securely
    var user_lat,
      user_lon,
      user_address,
      user_location_updated = 0,
      user_location_delay = 2000000,//1000 * 60 * 60; // 1 hour, in milliseconds
      exdays = 1, //location cookie expiry
      $location,

    // these getter/setter mehtods seem redundant
    // couldn't we access and assign the values directly or am I missing something?
    getUserLat = function () { return user_lat / 1; },
    getUserLon = function () { return user_lon / 1; },
    getUserAddress = function () { return user_address; },
    setUserLocationUpdated = function (time) { user_location_updated = time; },
    setUserLat = function (lat) { user_lat = lat / 1; },
    setUserLon = function (lon) { user_lon = lon / 1; },
    setUserAddress = function (address) { user_address = address; },

    userLocationError = function () {
      $location.html("Err");
    },

    locationLabel = function (msg) {
      return '<img src="/images/globe.png" alt="'+msg+'" width="20" height="20"/>';
    },

    showUserAddress = function (address) {
      $location.html(locationLabel(address));
    },

    showUserLocation = function (lat, lon) {
      $location.html(locationLabel(lat+','+lon));
    },

    updateUserLocation = function (force) {
      var lastupdated = user_location_updated,
        threshold = new Date().getTime() - user_location_delay,

      shouldUpdate = function() {
        return ( (user_location_updated < new Date().getTime() - user_location_delay) || force );
      };

      //alert('compare '+lastupdated+' to '+threshold+' = '+(threshold-lastupdated));
      if(shouldUpdate()) {
        updateLocationData();
      } else {
        showUserLocation(getUserLat(), getUserLon());
        showUserAddress(getUserAddress());
      }
    },

    updateLocationData = function () {
      if(geo_position_js.init()) {
        $location.html("<img src=\"/images/spinner.gif\"/>");
        geo_position_js.getCurrentPosition(setUserLocation,userLocationError);//{enableHighAccuracy:true}
      } else {
        $location.html("Automatic Location not available");
      }
      //we need to update this anyway so that it doesn't try to get location on _every_ page load.
      setUserLocationUpdated(new Date().getTime());
    },

    //callback from geo.js
    setUserLocation = function (p) {

      var lat = p.coords.latitude,
      lon = p.coords.longitude,
      pos=new google.maps.LatLng(lat,lon);

      showUserLocation(lat, lon);
      geocodeAddress(pos);

      /*
         setCookie('long', user_lon);
         setCookie('lat', user_lat);
         setCookie('location_updated', new Date().getTime());
         */

      var loc = {lat: lat / 1, lon: lon / 1}; // lat, lon
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
    },

    geocodeAddress = function(pos) {
      //Geocode to address. Oh yes.
      var geocoder = new google.maps.Geocoder(),

      geocodeSuccess = function(results) {
        var address = results[0].formatted_address;
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
            //setUserAddress(address);
          }
        });
      },

      geocodeDone = function (results, status) {
        if (status == google.maps.GeocoderStatus.OK) {
          geocodeSuccess(results);
        }
      };

      geocoder.geocode({'latLng': pos}, geocodeDone);

    },


    init = function () {
      $location = $('#location');
      user_lat = $.cookie('lat') / 1;
      user_lon = $.cookie('lon') / 1;
      user_address = $.cookie('address');
      user_location_updated = $.cookie('location_updated');

      $location.live('click', function(){updateUserLocation(true)});
      updateUserLocation();
    };

    return { init:init,
             getUserLat:getUserLat,
             getUserLon:getUserLon,
             getUserAddress:getUserAddress,
             setUserAddress:setUserAddress }

  }()); // Location END

  NavBar = (function () {
    var showTimer = false,

    showNavBar = function () {
     var win_y = $(window).height(),
       scroll_y = $(window).scrollTop();
     $("footer").css({ top: ((win_y - 36) + scroll_y) + "px" });
     $("header").css({ top: scroll_y + "px" });
    },

    maybeShowNavBar = function (evt) {
      showTimer ? clearTimeout(showTimer) : '';
      showTimer = setTimeout( showNavBar, 175 );
    },

    init = function() {
      // doesn't do anything yet
    };

    return { init:init }
  }()); // NavBar END


  var init = function () {
    Location.init();
    //clearinginput on report form elements
    $('.report input:text').clearingInput();
    $('.report textarea').clearingInput();

    //fade out alerts
    $('#notices').delay(2000).slideUp(1000);

  };

  // document ready shorthand, fires init method above
  $(init);

  // makes Location object accesable from ouside global Kajoo object
  return { Location:Location }

}($));












/**
 * extend jquery with "$('elem').scrollToMe();
 */
(function($) {
  //$(function() {

	$.fn.scrollToMe = function(){
		$('html,body').animate({
			height: this.offset().top
		}, 'fast');
	}

  $.cookie = function(key, value, options){
  // key and at least value given, set cookie...
  if (arguments.length > 1 && String(value) !== "[object Object]") {
      options = jQuery.extend({}, options);
      if (value === null || value === undefined) {
          options.expires = -1;
      }
      if (typeof options.expires === 'number') {
          var days = options.expires, t = options.expires = new Date();
          t.setDate(t.getDate() + days);
      }
      value = String(value);
      return (document.cookie = [
          encodeURIComponent(key), '=',
          options.raw ? value : encodeURIComponent(value),
          options.expires ? '; expires=' + options.expires.toUTCString() : '', // use expires attribute, max-age is not supported by IE
          options.path ? '; path=' + options.path : '',
          options.domain ? '; domain=' + options.domain : '',
          options.secure ? '; secure' : ''
      ].join(''));
    }

    // key and possibly options given, get cookie...
    options = value || {};
    var result, decode = options.raw ? function (s) { return s; } : decodeURIComponent;
    return (result = new RegExp('(?:^|; )' + encodeURIComponent(key) + '=([^;]*)').exec(document.cookie)) ? decode(result[1]) : null;
  };

  $.fn.animateHighlight = function(highlightColor, duration) {
    var highlightBg = highlightColor || "#FFFF9C";
    var animateMs = duration || 1500;
    var originalBg = this.css("backgroundColor");
    this.stop().css("background-color", highlightBg).animate({backgroundColor: originalBg}, animateMs);
  };
})(jQuery);

