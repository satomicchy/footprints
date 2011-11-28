class User < ActiveRecord::Base
  def self.create_with_omniauth(auth)  
    create(:provider => auth["provider"], :uid => auth["uid"], :name => auth["info"]["nickname"])
  end
end
