class RemoveThumbImageFromEvents < ActiveRecord::Migration[5.1]
  def change
    remove_column :events, :thumb_image, :text
  end
end
