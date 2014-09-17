class CreateTournamentGames < ActiveRecord::Migration
  def change
    create_table :tournament_games do |t|
      t.references :game
      t.references :tournament
      t.timestamps
    end
  end
end
