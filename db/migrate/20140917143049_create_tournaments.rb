class CreateTournaments < ActiveRecord::Migration
  def change
    create_table :tournaments do |t|
      t.string :name
      t.timestamp :start_at
      t.timestamp :end_at
      t.string :address
      t.float :longitude
      t.float :latitude
      t.integer :max_player
      t.references :user
      t.timestamps
    end
  end
end
