class PhotosController < ApplicationController
  def create
    current_user.photos.create(params[:photo])
    redirect_to user_map_path(current_user)
  end

  def destroy
  end
end
