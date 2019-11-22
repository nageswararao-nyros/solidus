module Spree
  class User < Spree::Base 
    attr_accessor :remember_me
    devise :omniauthable, omniauth_providers: [:google_oauth2]


     def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_create do |user|
     
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
    
      
    end
  end
  end
end
