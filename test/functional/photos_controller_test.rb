require 'test_helper'

class PhotosControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
    login_as(@user)
    stub_request(:post, "https://upload.twitter.com/1/statuses/update_with_media.json").to_return(:status => 200, :body => jsons(:update_with_media).to_json, :headers => {})
  end

  test "POST :create" do
    assert_difference("@user.photos.count", +1) do
      post :create, :photo => {:binary => fixture_file_upload('/photo.jpg', 'image/jpeg', :binary)}
    end
    assert_redirected_to user_map_path(@user)
  end

  test "GET :index of logged in users" do
    get :index, user_id: @user.to_param
    assert_response :success
    assert_equal 1, assigns(:photos).length
    assert_equal @user.id, assigns(:photos).first.user_id
    assert_tag :tag => 'a', :attributes => {:class => 'photo_destroy'}
  end

  test "GET :index of not logged in users" do
    user = users(:two)
    get :index, user_id: user.to_param
    assert_response :success
    assert_equal 1, assigns(:photos).length
    assert_equal user.id, assigns(:photos).first.user_id
    assert_no_tag :tag => 'a', :attributes => {:class => 'photo_destroy'}
  end
end
