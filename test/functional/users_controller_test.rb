require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
  end

  test "map" do
    get :map, :user_id => @user.to_param
    assert_equal 1, assigns(:events).values.flatten.length
    assert_equal 1, assigns(:friends).values.flatten.length
  end
end
