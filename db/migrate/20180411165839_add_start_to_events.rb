class AddStartToEvents < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :start, :datetime
  end
end
