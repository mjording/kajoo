var currAddress;
var currPosition;
var window = {}; //for compatibility with geo.js

var navigator;

//importScripts('/javascripts/geo_position_js_simulator.js');
importScripts('/javascripts/geo.js');

onmessage = function(e){
/*  if ( e.data['geolocate'] === "start" ) {*/
  
  navigator = function() {
    var pub = {};
    
    pub.geolocation = e.data['geolocation'];
    
    return pub;
    
  }();
  
  alert(e['data'].geolocation);
  
  navigator.geolocation.getCurrentPosition(function(){alert('success')},function(){alert('error')},{});
  
  // Do some computation
  if(geo_position_js.init()){
    geo_position_js.getCurrentPosition(geocode_and_report_position,function(){postMessage({'error':'Couldn\'t get location'})},{enableHighAccuracy:true});
  } else {
    postMessage({'error': 'Could not initialize geo.js'});
  };
//  }
};

function alert(message) {
  postMessage({'error': message});
}

function geocode_and_report_position(p) {
  if(p != currPosition) {
    postMessage({'pos':p});
    currPosition = p;
  }

  geocoder = new google.maps.Geocoder();
  var pos=new google.maps.LatLng(p.coords.latitude,p.coords.longitude);
  geocoder.geocode({'latLng': pos}, function(results, status) {
    if (status == google.maps.GeocoderStatus.OK) {
      var address = results[1].formatted_address;
      if(address != currAddress) {
        postMessage({'address': address});
      }
    }
  });
}