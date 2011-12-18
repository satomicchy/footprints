require 'test_helper'

class PhotosControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
    login_as(@user)
  end

  test "POST :create" do
    assert_difference("@user.photos.count", +1) do
      post :create, :photo => {:binary => fixture_file_upload('/photo.jpg', 'image/jpeg', :binary)}
    end
    assert_redirected_to map_events_path
  end
end
