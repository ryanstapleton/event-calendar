class User < ApplicationRecord
  ############################################################################################
  ## PeterGate Roles                                                                        ##
  ## The :user role is added by default and shouldn't be included in this list.             ##
  ## The :root_admin can access any page regardless of access settings. Use with caution!   ##
  ## The multiple option can be set to true if you need users to have multiple roles.       ##
  petergate(roles: [:admin], multiple: false)                                      ##
  ############################################################################################ 
 

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
		 :recoverable, :rememberable, :trackable, :validatable, :omniauthable, omniauth_providers: [:google_oauth2]

  has_many :rsvps, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :events, dependent: :destroy

  validates_presence_of :name
  
  def self.find_for_google_oauth2(auth)
    puts "=========================================Logged In=======================================================" * 10
    data = auth.info
    # user = User.where(email: data['email']).first

    if validate_email(auth)
      user = User.where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.provider = auth.provider
        user.uid = auth.uid
        user.email = auth.info.email
        user.password = Devise.friendly_token[0,20]
      end
      user.token = auth.credentials.token
      user.refresh_token = auth.credentials.refresh_token
      user.save
      return user
    else
      return nil
    end
  end

end
