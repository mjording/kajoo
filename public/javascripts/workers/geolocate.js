

function onMessage(event) {
  //event.data['geo'](setUserLocation,userLocationError,{enableHighAccuracy:true});
  
  var data = event.data;
  
/*
  if(data.func) {
    postMessage({alert: data.func()});
  }
*/
  
  
  if (navigator.geolocation){
    postMessage({alert: 'geolocation supported'});
  };
  
  postMessage({address: '52 Keele St'});
};

function setUserLocation(p) {
  postMessage({lat: p.coords.latitude, lon: p.coords.longitude});
}

function userLocationError() {
  throw 'Couldn\'t get location';
}

function alert(mesage) {
  throw message;
}

addEventListener('message', onMessage, false);
addEventListener('error', alert, false);