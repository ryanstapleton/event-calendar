class Rsvp < ApplicationRecord
  belongs_to :user
  belongs_to :event

  def self.current
    where("start >= ?", DateTime.now)
  end
end
