class FixColumnName < ActiveRecord::Migration
  def change
    rename_column :games, :uid, :user_id
  end
end
