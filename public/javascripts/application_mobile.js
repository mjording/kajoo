//ensure that the navigation bar stays on the top of the screen on ipad/iphone/android
window.onscroll = function() {
  document.getElementById('navigation').style.top = window.pageYOffset+'px';//(window.pageYOffset + window.innerHeight - 25) + 'px'
  document.getElementById('notices').style.top = (window.pageYOffset+25)+'px';
};