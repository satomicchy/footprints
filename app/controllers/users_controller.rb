class UsersController < ApplicationController
  def map
    @events = user_of_context.events.group_by {|event| [event.latitude, event.longitude] }
    @friends = user_of_context.friends.group_by {|friend| [friend.latitude, friend.longitude] }
    @photos = user_of_context.photos.where("latitude is NOT NULL").group_by {|friend| [friend.latitude, friend.longitude] }

  end
end
