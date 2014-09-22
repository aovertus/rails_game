class MatchesController < ApplicationController
  before_action :set_match, only: [:update]
  def index
    @tournament = Tournament.find(params[:tournament_id])
    @users = User.all
    @matches = @tournament.matches.all
  end
  
  def new 
    @match = Match.new
  end
  
  def create
    @match = Match.new(match_params)
    @match.tournament = Tournament.find(params[:tournament_id])
      if @match.save
        redirect_to :back, notice: 'Match was successfully created.' 
      end
  end
  
  def update   
      if @match.update(score_params)
        redirect_to :back, notice: 'Score was successfully updated.' 
      end
  end

  
  private 
    def match_params
      params.require(:match).permit(:tournament_id, :game_id, :player_one_id, :player_two_id)
    end
    
    def score_params
      params.require(:match).permit(:score_one, :score_two)
    end
    
    def set_match
      @match= Match.find(params[:id])
    end
end