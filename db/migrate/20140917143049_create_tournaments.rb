class CreateTournaments < ActiveRecord::Migration
  def change
    create_table :tournaments do |t|
      t.timestamps :start_at
      t.timestamps :end_at
      t.string :place
      t.integer :max_player
      t.references :user
      t.timestamps
    end
  end
end
