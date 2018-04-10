class AddAccessTokenToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :access_token, :text
  end
end
