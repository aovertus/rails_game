class CreateTournamentPlayers < ActiveRecord::Migration
  def change
    create_table :tournament_players do |t|
      t.references :user
      t.references :tournament
      t.timestamps
    end
  end
end
