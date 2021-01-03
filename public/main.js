mySocket = new WebSocket("ws://" + window.location.host + "/");

mySocket.onopen = function(event) {
};

mySocket.onmessage = function(event) {
  bodyelement = document.getElementsByClassName('main-content')[0];

  svgelement = document.getElementById('mysvg');
  if(svgelement === null) {
    bodyelement.innerHTML = event.data;
  } else {
    bodyelement.removeChild(svgelement);
    bodyelement.innerHTML = event.data;
  }
};

mySocket.onclose = function(event) {
};