jQuery ($) ->
  latlng = new google.maps.LatLng(34.663411, 135.50191);
  myOptions = {
    zoom: 12,
    center: latlng,
    mapTypeId: google.maps.MapTypeId.ROADMAP,
    streetViewControl: false
  };
  map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);
