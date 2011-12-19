class UsersController < ApplicationController
  def map
    user_id = params[:user] ? params[:user][:id] : current_user.id
    @events = Event.where("user_id = ?", user_id)
      .group_by {|event| [event.latitude, event.longitude] }
    @friends = Friend.where("user_id = ?", user_id)
      .group_by {|friend| [friend.latitude, friend.longitude] }
  end
end
