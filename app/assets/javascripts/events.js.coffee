jQuery ($) ->
  latlng = new google.maps.LatLng(34.663411, 135.50191);
  myOptions = {
    zoom: 12,
    center: latlng,
    mapTypeId: google.maps.MapTypeId.ROADMAP,
    streetViewControl: false
  };
  map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);

  $('#event_button').click ->
    params = $("#new_event").serialize()
    textfield = $("#event_name")
    if textfield.val().length > 0
      textfield.val("")
      $.post("/events.json", params).done(->
        $("#events_list").load("/events")
      )
