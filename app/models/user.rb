class User < ActiveRecord::Base
  has_many :events
  has_many :friends
  has_many :photos

  def self.create_with_omniauth(auth)
    attributes = {:provider => auth["provider"], :uid => auth["uid"], :name => auth["info"]["nickname"]}
    if attributes[:provider] == 'twitter'
      attributes.update(:twitter_token => auth.credentials.token, :twitter_secret => auth.credentials.secret)
    end
    create(attributes)
  end
end
