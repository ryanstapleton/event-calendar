class AddMainImageToEvents < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :main_image, :string
  end
end
