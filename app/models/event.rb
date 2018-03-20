class Event < ApplicationRecord
  has_many :rsvps
  has_many :favorites
  belongs_to :user
  # has_many :users, through: :rsvps
  # has_many :users, through: :favorites

  mount_uploader :main_image, EventUploader
  validates_presence_of :title, :body, :date, :location
end
