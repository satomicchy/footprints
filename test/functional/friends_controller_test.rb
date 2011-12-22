require 'test_helper'

class FriendsControllerTest < ActionController::TestCase
  setup do
    @friend = friends(:one)
    @user = users(:one)
    login_as(@user)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create friend" do
    assert_difference('Friend.count') do
      post :create, friend: @friend.attributes
    end

    assert_redirected_to friend_path(assigns(:friend))
  end

  test "should show friend" do
    get :show, user_id: @user.to_param, id: @friend.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @friend.to_param
    assert_response :success
  end

  test "should update friend" do
    put :update, id: @friend.to_param, friend: @friend.attributes
    assert_redirected_to friend_path(assigns(:friend))
  end

  test "should destroy friend" do
    assert_difference('Friend.count', -1) do
      delete :destroy, id: @friend.to_param
    end

    assert_redirected_to user_events_path(@user)
  end
end
