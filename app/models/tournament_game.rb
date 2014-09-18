class TournamentGame < ActiveRecord::Base
  belongs_to :game
  belongs_to :tournament
  
  validates_presence_of :game
  validates_presence_of :tournament
  accepts_nested_attributes_for :game
end
