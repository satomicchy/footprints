jQuery ($) ->
  events_list = (events) ->
    """
    <div>
      <ul>
    #{("<li><a href=\"/events/#{event.id}\">#{event.name}</a></li>" for event in events).join("\n")}
      </ul>
    </div>
    """

  friends_list = (friends) ->
    """
    <div>
       <ul>
    #{("<li><a href=\"/friends/#{friend.id}\">#{friend.name}</a></li>" for friend in friends).join("\n")}
       </ul>
     </div>
     """

  if $("#map_canvas").length > 0
    myOptions = {
      zoom: 12,
      center: new google.maps.LatLng(34.663411, 135.50191),
      mapTypeId: google.maps.MapTypeId.ROADMAP,
      mapTypeControl: false,
      streetViewControl: false
    };
    document.map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);
    document.event_markers = []
    document.friend_markers = []

    for events_latlng, same_place_events of events
      do (events_latlng, same_place_events) ->
        latlng = $.parseJSON(events_latlng)
        marker = new google.maps.Marker({
          map: document.map
          position: new google.maps.LatLng(latlng[0], latlng[1])
          icon: "http://dl.dropbox.com/u/4039576/footprint_marker.gif"
        })
        infowin = new google.maps.InfoWindow({
          content: events_list(same_place_events)
          position: marker.getPosition()
        })
        google.maps.event.addListener(marker, 'click',
                                      -> infowin.open(document.map, marker))
        document.event_markers.push({marker: marker, infowin: infowin})

    for friends_latlng, same_place_friends of friends
      do (friends_latlng, same_place_friends) ->
        latlng = $.parseJSON(friends_latlng)
        marker = new google.maps.Marker({
          map: document.map
          position: new google.maps.LatLng(latlng[0], latlng[1])
          icon: "http://dl.dropbox.com/u/4039576/footprint_marker2.gif"
        })
        infowin = new google.maps.InfoWindow({
          content: friends_list(same_place_friends)
          position: marker.getPosition()
        })
        google.maps.event.addListener(marker, 'click',
                                      -> infowin.open(document.map, marker))
        document.friend_markers.push({marker: marker, infowin: infowin})

    google.maps.event.addListener(document.map, 'click', ->
      for marker_obj in document.event_markers
        do (marker_obj) ->
          marker_obj.infowin.close()
      for marker_obj in document.friend_markers
        do (marker_obj) ->
          marker_obj.infowin.close())
