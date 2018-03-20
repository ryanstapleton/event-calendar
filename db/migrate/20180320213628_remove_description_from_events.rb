class RemoveDescriptionFromEvents < ActiveRecord::Migration[5.1]
  def change
    remove_column :events, :description, :text
  end
end
