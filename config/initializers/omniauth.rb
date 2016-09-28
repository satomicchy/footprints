Rails.application.config.middleware.use OmniAuth::Builder do
  TwitterOAuth = if Rails.env.production?
           {"CONSUMER_KEY" => ENV["TWITTER_CONSUMER_KEY"], "CONSUMER_SECRET" => ENV["TWITTER_CONSUMER_SECRET"]}
         else
           YAML::load(File.open("config/twitter.yml"))
         end
  provider :twitter, TwitterOAuth["CONSUMER_KEY"], TwitterOAuth["CONSUMER_SECRET"]
end
