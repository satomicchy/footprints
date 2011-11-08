jQuery ($) ->
  if $("#map_canvas").length > 0
    latlng = new google.maps.LatLng(34.663411, 135.50191);
    myOptions = {
      zoom: 12,
      center: latlng,
      mapTypeId: google.maps.MapTypeId.ROADMAP,
      mapTypeControl: false,
      streetViewControl: false
    };
    map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);

    marker = new google.maps.Marker({
      position: latlng,
      map: map,
      title:"Hello World!"
    });