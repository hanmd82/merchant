class User < ActiveRecord::Base
  def self.find_or_create_by_auth(auth_data)
    create_with(name: auth_data["info"]["name"]).find_or_create_by(
    	provider: auth_data["provider"], uid: auth_data["uid"])
  end
end
