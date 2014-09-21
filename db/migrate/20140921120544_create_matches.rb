class CreateMatches < ActiveRecord::Migration
  def up
    create_table :matches do |t|
      t.references :tournament
      t.references :game
      t.references :player_one
      t.integer :score_one
      t.references :player_two
      t.integer :score_two
      t.timestamps
    end
  end
end
