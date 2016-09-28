require 'test_helper'

class EventsControllerTest < ActionController::TestCase
  setup do
    @event = events(:one)
    @user = users(:one)
    login_as(@user)

    stub_google_location_api(100, 200)
  end

  test "should get index" do
    get :index, user_id: @user.to_param
    assert_response :success
    assert_not_nil assigns(:events)
    ["friend", "event"].each do |k|
      assert_tag :tag => 'a', :attributes => {:href => send("user_#{k}_path", @user, assigns(k.pluralize.to_sym).first)}
    end
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create event" do
    assert_difference('Event.count') do
      post :create, event: @event.attributes
    end

    assert_redirected_to event_path(assigns(:event))
  end

  test "should show event" do
    get :show, id: @event.to_param, user_id: @user.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @event.to_param
    assert_response :success
  end

  test "should update event" do
    put :update, id: @event.to_param, event: @event.attributes
    assert_redirected_to event_path(assigns(:event))
  end

  test "should destroy event" do
    assert_difference('Event.count', -1) do
      delete :destroy, id: @event.to_param
    end

    assert_redirected_to user_events_path(assigns(:current_user))
  end
end
