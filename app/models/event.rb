class Event < ApplicationRecord
  enum status: { pending: 0, approved: 1, rejected: 2}
  
  has_many :rsvps, dependent: :destroy
  has_many :favorites, dependent: :destroy
  belongs_to :user

  mount_uploader :main_image, EventUploader
  validates_presence_of :title, :body, :date, :location
end
