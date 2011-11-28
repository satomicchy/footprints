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

    for latlng, same_place_events of events
      do (latlng, same_place_events) ->
        marker = new google.maps.Marker({
          position: new google.maps.LatLng($.parseJSON(latlng)[0], $.parseJSON(latlng)[1]),
          map: document.map,
          icon: "http://dl.dropbox.com/u/4039576/footprint_marker.gif"
        })
        infowin = new google.maps.InfoWindow({
          content: event_list(same_place_events)
          position: marker.getPosition()
        })
        google.maps.event.addListener marker, 'click', (click_event) ->
          infowin.open(document.map, marker)

    for latlng, same_place_friends of friends
      do (latlng, same_place_friends) ->
        marker = new google.maps.Marker({
          position: new google.maps.LatLng($.parseJSON(latlng)[0], $.parseJSON(latlng)[1]),
          map: document.map,
          icon: "http://dl.dropbox.com/u/4039576/footprint_marker2.gif"
        })
        infowin = new google.maps.InfoWindow({
          content: friend_list(same_place_friends)
          position: marker.getPosition()
        })
        google.maps.event.addListener marker, 'click', (click_event) ->
          infowin.open(document.map, marker)

event_list = (events) ->
  result = "<div>\n  <ul>\n"
  for event in events
    result += "    <li><a href=\"/events/#{event.id}\">#{event.name}</a></li>\n"
  result += "  </ul>\n</div>\n"

friend_list = (friends) ->
  result = "<div>\n  <ul>\n"
  for friend in friends
    result += "    <li><a href=\"/friends/#{friend.id}\">#{friend.name}</a></li>\n"
  result += "  </ul>\n</div>\n"
