require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
    @forms = ['new_event', 'new_friend']
  end

  test "no logged in user access to map" do
    get :map, :user_id => @user.to_param
    assert_equal 1, assigns(:events).values.flatten.length
    assert_equal 1, assigns(:friends).values.flatten.length
    @forms.each do |id|
      assert_no_tag :tag => 'form', :attributes => {:id => id}
    end
  end

  test "logged in user access my map" do
    login_as(@user)
    get :map, :user_id => @user.to_param
    @forms.each do |id|
      assert_tag :tag => 'form', :attributes => {:id => id}
    end
  end
end
