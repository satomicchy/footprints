require 'test_helper'

class PhotoTest < ActiveSupport::TestCase
  include ActionDispatch::TestProcess
  test "extract geo point" do
    photo = Photo.new(:binary => fixture_file_upload('/photo.jpg', 'image/jpeg', :binary))
    photo.extract_geopoint!
    assert_equal 34.97398669444444, photo.latitude
    assert_equal 139.09536980555555, photo.longitude
  end
end
