class AddThumbImageToEvents < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :thumb_image, :string
  end
end
