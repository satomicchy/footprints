require 'test_helper'

class TwitterLoginTest < ActionDispatch::IntegrationTest
  fixtures :all
  setup do
    stub_twitter_oauth({:screen_name => "yalab", :name => "Atsushi Yoshida"})
  end
  test "twitter login" do
    assert_difference('User.count', +1) do
      get '/auth/twitter'
      assert_match %r|https://api.twitter.com/oauth/authenticate|, response.header['Location']
      follow_redirect!
      assert_match %r|http://#{request.host}/auth/twitter/callback|, response.header['Location']
      follow_redirect!
      assert_match %r|http://#{request.host}/events/map|, response.header['Location']
    end
  end
end
