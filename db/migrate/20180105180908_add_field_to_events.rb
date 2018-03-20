class AddFieldToEvents < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :description, :text
    add_column :events, :location, :text
    add_column :events, :date, :date
    add_column :events, :thumb_image, :text
  end
end
