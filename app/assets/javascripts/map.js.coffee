jQuery ($) ->
  if $("#map_canvas").length > 0
    myOptions = {
      zoom: 12,
      center: new google.maps.LatLng(34.663411, 135.50191),
      mapTypeId: google.maps.MapTypeId.ROADMAP,
      mapTypeControl: false,
      streetViewControl: false
    };
    document.map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);

    $(events).each (i, event) ->
      new google.maps.Marker({
        position: new google.maps.LatLng(event.latitude, event.longitude),
        map: document.map,
        title: event.name,
        icon: "http://dl.dropbox.com/u/4039576/footprint_marker.gif"
      });

    $(friends).each (i, friend) ->
      new google.maps.Marker({
        position: new google.maps.LatLng(friend.latitude, friend.longitude),
        map: document.map,
        title: friend.name,
        icon: "http://dl.dropbox.com/u/4039576/footprint_marker2.gif"
      });
