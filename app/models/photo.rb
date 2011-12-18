class Photo < ActiveRecord::Base
  belongs_to :user
  attr_accessor :binary

  def extract_geopoint!
    tags = EXIFR::JPEG.new(binary.path)
    if (exif = tags.exif) && exif[:gps_latitude] && exif[:gps_longitude]
      [:latitude, :longitude].each{|tag|
        (h, m, s) = exif[:"gps_#{tag}"]
        self[tag] = (h + m / 60 + s / 3600).to_f
      }
    end
  end

  def post_to_twitter
    Twitter.configure do |config|
      config.consumer_key       = TwitterOAuth["CONSUMER_KEY"]
      config.consumer_secret    = TwitterOAuth["CONSUMER_SECRET"]
      config.oauth_token        = user.twitter_token
      config.oauth_token_secret = user.twitter_secret
    end
    Twitter.update_with_media("", File.new(binary.path))
  end
end