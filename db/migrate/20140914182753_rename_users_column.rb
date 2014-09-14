class RenameUsersColumn < ActiveRecord::Migration
  def change
    rename_column :users, :oath_expires_at, :oauth_expires_at
  end
end
