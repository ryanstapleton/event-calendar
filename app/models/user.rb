class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
		 :recoverable, :rememberable, :trackable, :validatable

  has_many :rsvps
  has_many :favorites
  has_many :events
  # has_many :events, through: :rsvps
  # has_many :events, through: :favorites

	validates_presence_of :name
end
