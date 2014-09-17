class TournamentPlayer < ActiveRecord::Base
  belongs_to :user
  belongs_to :tournament
end
