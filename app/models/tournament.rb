class Tournament < ActiveRecord::Base
  has_many :tournament_players
  has_many :tournament_games
  has_many :users, through: :tournament_players
  has_many :games, through: :tournament_games
  geocoded_by :address
  after_validation :geocode, :if => :address_changed?
  accepts_nested_attributes_for :games
end
