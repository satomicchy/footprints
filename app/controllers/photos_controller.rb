class PhotosController < ApplicationController
  def index
    @photos = user_of_context.photos
  end

  def create
    current_user.photos.create(params[:photo])
    redirect_to user_map_path(current_user)
  end

  def destroy
  end
end
