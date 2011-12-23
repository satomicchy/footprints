require 'test_helper'

class PhotoTest < ActiveSupport::TestCase
  include ActionDispatch::TestProcess
  setup do
    @user = users(:one)
    @photo = @user.photos.new(:binary => fixture_file_upload('/photo.jpg', 'image/jpeg', :binary))

    @response_body =  jsons(:update_with_media)
    stub_request(:post, "https://upload.twitter.com/1/statuses/update_with_media.json").to_return(:status => 200, :body => @response_body.to_json, :headers => {})
  end

  test "extract geo point" do
    @photo.extract_geopoint!
    assert_equal 34.97398669444444, @photo.latitude
    assert_equal 139.09536980555555, @photo.longitude
  end

  test "post to twitter" do
    response = @photo.post_to_twitter
    assert_instance_of Twitter::Status, response
    assert_equal @response_body["entities"]["media"].first["id_str"], @photo.id_str
    assert_equal @response_body["entities"]["media"].first["media_url_https"], @photo.url
  end

  test "set callbacks" do
    callbacks = Photo._create_callbacks.map(&:raw_filter)
    assert_includes callbacks, :extract_geopoint!
    assert_includes callbacks, :post_to_twitter
  end
end
