jQuery ($) ->
  $('#friend_button').click ->
    params = $("#new_friend").serialize()
    textfield = $("#friend_name")
    if textfield.val().length > 0
      textfield.val("")
      $.post("/friends.json", params).done(->
        $("#friends_list").load("/friends")
      )

