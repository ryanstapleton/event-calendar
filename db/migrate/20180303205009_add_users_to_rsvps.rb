class AddUsersToRsvps < ActiveRecord::Migration[5.1]
  def change
    add_reference :rsvps, :user, foreign_key: true
  end
end
