require 'test_helper'

class TwitterLoginTest < ActionDispatch::IntegrationTest
  fixtures :all
  setup do
    @user = {:screen_name => "yalab", :name => "Atsushi Yoshida"}
    stub_twitter_oauth(@user)
  end
  test "twitter login" do
    assert_difference('User.count', +1) do
      get '/auth/twitter'
      assert_match %r|https://api.twitter.com/oauth/authenticate|, response.header['Location']
      follow_redirect!
      assert_match %r|http://#{request.host}/auth/twitter/callback|, response.header['Location']
      follow_redirect!
      user =  User.last
      assert_equal user_map_url(user), response.header['Location']

      assert_equal @user[:screen_name], user.name
      assert_not_nil user.twitter_token
      assert_not_nil user.twitter_secret
    end
  end
end
