Rails.application.config.middleware.use OmniAuth::Builder do
  keys = if Rails.env.production?
           {"CONSUMER_KEY" => ENV["TWITTER_CONSUMER_KEY"], "CONSUMER_SECRET" => ENV["TWITTER_CONSUMER_SECRET"]}
         else
           YAML::load(File.open("config/twitter.yml"))
         end
  provider :twitter, keys["CONSUMER_KEY"], keys["CONSUMER_SECRET"]
end
