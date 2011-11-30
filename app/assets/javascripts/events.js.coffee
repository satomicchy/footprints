jQuery ($) ->
  insert_list = (content, event) ->
    list_regex = /<li>.*<\/li>/g
    """
    <div>
      <ul>
      #{("#{element}" for element in content.match(list_regex)).join("\n")}
      <li><a href=\"/events/#{event.id}\">#{event.name}</a></li>
      </ul>
    </div>
    """

  $('#event_button').click ->
    params = $("#new_event").serialize()
    textfield = $("#event_name")
    if textfield.val().length > 0
      textfield.val("")
      $.post("/events.json", params).done (event)->
        latlng = new google.maps.LatLng(event.latitude, event.longitude)
        for marker_obj in document.event_markers when marker_obj.marker.getPosition().equals(latlng)
          already_marked =  marker_obj
        if already_marked?
          already_marked.infowin.setContent(
            insert_list(already_marked.infowin.getContent(),
                        event)
          )
        else
          marker = new google.maps.Marker({
            position: latlng
            map: document.map,
            icon: "http://dl.dropbox.com/u/4039576/footprint_marker.gif"
          })
          infowin = new google.maps.InfoWindow({
            content: """
                     <div>
                       <ul>
                         <li><a href=\"/events/#{event.id}\">#{event.name}</a></li>
                       </ul>
                     </div>
                     """
            position: marker.getPosition()
          })
          google.maps.event.addListener(marker, 'click', ->
            infowin.open(document.map, marker))
          document.event_markers.push({marker: marker, infowin: infowin})
