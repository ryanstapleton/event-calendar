class AddEndToEvents < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :end, :datetime
  end
end
