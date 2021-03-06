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
    puts "=========================================User Access=======================================================" * 10
    data = auth.info
    user = User.where(email: data['email']).first

    user.provider = auth.provider
    user.uid = auth.uid
    user.access_token = auth.credentials.token
    user.refresh_token = auth.credentials.refresh_token
    user.save
  end
end
