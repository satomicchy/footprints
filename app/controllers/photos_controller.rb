class PhotosController < ApplicationController
  def create
    current_user.photos.create(params[:photo])
    redirect_to map_events_path
  end

  def destroy
  end
end
