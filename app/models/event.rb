class Event < ApplicationRecord
  enum status: { pending: 0, approved: 1, rejected: 2}
  
  has_many :rsvps, dependent: :destroy
  has_many :favorites, dependent: :destroy
  belongs_to :user

  mount_uploader :main_image, EventUploader
  validates_presence_of :title, :body, :start, :location, :main_image

  def format_for_google
    event_hash = {
      summary: self.title,
      location: self.location,
      start: self.start.strftime("%Y-%m-%dT%H:%M:%S%z"),
      end: (self.start + self.end.chomp(" hours").to_i.hours).strftime("%Y-%m-%dT%H:%M:%S%z"),
      description: self.body
    }
  end

end
