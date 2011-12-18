ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'webmock/test_unit'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def login_as(user)
    session[:user_id] = user.id
  end

  def stub_google_location_api(lat, lng)
    address = {:results => [{:geometry => {:location => {:lat => lat, :lng => lng}}}]}
    stub_request(:get, "http://maps.google.com/maps/api/geocode/json?address=MyString&sensor=false").to_return(:status => 200, :body => address.to_json, :headers => {})
  end
end

module ActionDispatch::Integration::RequestHelpers
  def follow_redirect_with_other_host!
    location = URI.parse(response.location)
    return follow_redirect_without_other_host! if location.host == request.host
    res = nil
    Net::HTTP.start(location.host, location.port, :use_ssl => true) do |http|
      res = http.request(Net::HTTP::Get.new location.request_uri)
    end

    if res.is_a?(Net::HTTPRedirection)
      @response = ActionDispatch::TestResponse.new.tap{|r|
        r.status = res.code
        r.body = res.body
        r.headers = Hash[res.header.to_hash.map{|k, v| [k.capitalize, v.join] }]
      }
    end
    status
  end
  alias_method_chain :follow_redirect!, :other_host
end

class ActionDispatch::IntegrationTest
  def stub_twitter_oauth(user)
    oauth_token = Digest::SHA1.hexdigest(Time.now.to_f.to_s)
    oauth_token_secret = Digest::SHA1.hexdigest(Time.now.to_i.to_s)
    callback_url = url_for(:controller=>"sessions", :action=>"create", :provider => "twitter", :oauth_token => oauth_token, :oauth_verifier => Digest::SHA1.hexdigest(Time.now.to_f.to_s))

    {"/oauth/request_token" =>
      [:post, 200, 'oauth_token=#{oauth_token}&oauth_token_secret=#{oauth_token_secret}&oauth_callback_confirmed=true', {}],

     "/oauth/authenticate?oauth_token=%23%7Boauth_token%7D" =>
      [:get, 302, '', {'Location' => callback_url}],

     "/oauth/access_token" =>
      [:post, 200, "oauth_token=#{oauth_token}&oauth_token_secret=#{oauth_token_secret}&screen_name=#{user[:screen_name]}", {}],

     "/1/account/verify_credentials.json" =>
      [:get, 200, user.to_json, {}]}.each do |path, http|
      (method, status, body, header) = http
      stub_request(method, "https://api.twitter.com" + path).to_return(:status => status, :body => body, :headers => header)
    end
  end
end
