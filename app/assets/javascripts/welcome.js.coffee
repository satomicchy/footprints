jQuery ($) ->
  $("#see_button").click ->
    id = $("#user_id").val()
    if id > 0
      location.href = "/users/#{id}/map"
