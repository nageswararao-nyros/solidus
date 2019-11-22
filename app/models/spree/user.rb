module Spree
  class User < Spree::Base
    include UserMethods
  devise :database_authenticatable,:registerable,
         :recoverable, :rememberable, :validatable, :lockable, :timeoutable, :trackable,
         :omniauthable, :omniauth_providers => [:google_oauth2, :facebook]
  

  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_now
  end

  # def self.from_omniauth(auth)
  #   where(auth.slice(:provider, :uid)).first_or_create do |user|
     
  #     user.email = auth.info.email
  #     user.password = Devise.friendly_token[0,20]
  #     user.name = auth.info.name   # assuming the user model has a name
      
  #   end
  # end

  def self.from_omniauth(auth)
    # Either create a User record or update it based on the provider (Google) and the UID   
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.token = auth.credentials.token
      user.expires = auth.credentials.expires
      user.expires_at = auth.credentials.expires_at
      user.refresh_token = auth.credentials.refresh_token
    end
  end


  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"], without_protection: true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end
    acts_as_paranoid
    after_destroy :scramble_email_and_password

    def password=(new_password)
      generate_spree_api_key if new_password.present? && spree_api_key.present?
      super
    end

    before_validation :set_login

    scope :admin, -> { includes(:spree_roles).where("#{Role.table_name}.name" => "admin") }

    def self.admin_created?
      User.admin.count > 0
    end

    def admin?
      has_spree_role?('admin')
    end

    def confirmed?
      !!confirmed_at
    end

    protected

    def password_required?
      !persisted? || password.present? || password_confirmation.present?
    end

    private

    def set_login
      # for now force login to be same as email, eventually we will make this configurable, etc.
      self.login ||= email if email
    end

    def scramble_email_and_password
      self.email = SecureRandom.uuid + "@example.net"
      self.login = email
      self.password = SecureRandom.hex(8)
      self.password_confirmation = password
      save
    end
  end
end