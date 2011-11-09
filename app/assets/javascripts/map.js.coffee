jQuery ($) ->
  if $("#map_canvas").length > 0
    myOptions = {
      zoom: 12,
      center: new google.maps.LatLng(34.663411, 135.50191),
      mapTypeId: google.maps.MapTypeId.ROADMAP,
      mapTypeControl: false,
      streetViewControl: false
    };
    map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);

    $(events).each (i, event) ->
      console.log(event)
      new google.maps.Marker({
        position: new google.maps.LatLng(event.latitude, event.longitude),
        map: map,
        title: event.name
      });
