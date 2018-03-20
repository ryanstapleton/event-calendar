class AddEventsToFavorites < ActiveRecord::Migration[5.1]
  def change
    add_reference :favorites, :event, foreign_key: true
  end
end
