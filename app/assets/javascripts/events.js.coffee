jQuery ($) ->
  $('#event_button').click ->
    alert('hoge')
    params = $("#new_event").serialize()
    textfield = $("#event_name")
    if textfield.val().length > 0
      textfield.val("")
      $.post("/events.json", params).done(->
        $("#events_list").load("/events")
      )
