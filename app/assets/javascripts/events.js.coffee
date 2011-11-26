jQuery ($) ->
  $('#event_button').click ->
    params = $("#new_event").serialize()
    textfield = $("#event_name")
    if textfield.val().length > 0
      textfield.val("")
      $.post("/events.json", params).done (event)->
        new google.maps.Marker({
          position: new google.maps.LatLng(event.latitude, event.longitude),
          map: document.map,
          title: event.name,
          icon: "http://dl.dropbox.com/u/4039576/footprint_marker.gif"
        })
