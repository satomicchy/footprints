jQuery ($) ->
  $('#friend_button').click ->
    params = $("#new_friend").serialize()
    textfield = $("#friend_name")
    if textfield.val().length > 0
      textfield.val("")
      $.post("/friends.json", params).done (friend)->
        new google.maps.Marker({
          position: new google.maps.LatLng(friend.latitude, friend.longitude),
          map: document.map,
          title: friend.name,
          icon: "http://dl.dropbox.com/u/4039576/footprint_marker2.gif"
        })
