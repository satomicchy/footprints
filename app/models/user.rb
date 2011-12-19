class User < ActiveRecord::Base
  has_many :events
  has_many :friends

  def self.create_with_omniauth(auth)  
    create(:provider => auth["provider"], :uid => auth["uid"], :name => auth["info"]["nickname"])
  end
end
