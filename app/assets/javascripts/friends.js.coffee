jQuery ($) ->
  li_elements = (content) ->
    list_regex = /<li>.*<\/li>/g
    if list_regex.test(content)
      "#{element}" for element in content.match(list_regex)
    else
      []

  li = (friend) ->
    "<li><a href=\"/friends/#{friend.id}\">#{friend.name}</a></li>"

  insert_list = (content, friend) ->
    """
    <div>
      <ul>
        #{li_elements(content).join("\n")}
        #{li(friend)}
      </ul>
    </div>
    """

  $('#friend_button').click ->
    params = $("#new_friend").serialize()
    textfield = $("#friend_name")
    if textfield.val().length > 0
      textfield.val("")
      $.post("/friends.json", params).done (friend)->
        latlng = new google.maps.LatLng(friend.latitude, friend.longitude)
        for marker_obj in document.friend_markers when marker_obj.marker.getPosition().equals(latlng)
          already_marked =  marker_obj
        if already_marked?
          already_marked.infowin.setContent(
            insert_list(already_marked.infowin.getContent(),
                        friend)
          )
        else
          marker = new google.maps.Marker({
            position: latlng
            map: document.map,
            icon: "http://dl.dropbox.com/u/4039576/footprint_marker2.gif"
          })
          infowin = new google.maps.InfoWindow({
            content: insert_list("", friend)
            position: marker.getPosition()
          })
          google.maps.event.addListener(marker, 'click', ->
            infowin.open(document.map, marker))
          document.friend_markers.push({marker: marker, infowin: infowin})

