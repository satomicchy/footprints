Rails.application.config.middleware.use OmniAuth::Builder do
  keys = YAML::load(File.open("config/twitter.yml"))
  provider :twitter, keys["CONSUMER_KEY"], keys["CONSUMER_SECRET"]
end
