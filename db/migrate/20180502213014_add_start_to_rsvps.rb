class AddStartToRsvps < ActiveRecord::Migration[5.1]
  def change
    add_column :rsvps, :start, :datetime
  end
end
