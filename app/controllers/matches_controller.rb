class MatchesController < ApplicationController
  before_action :set_match, only: [:update, :delete]
  before_action :set_tournament, only: [:index, :show]
  before_filter :authenticate

  def index
    @users = User.all
    @matches = @tournament.matches.order(params[:sort])
  end
  
  def all
    @matches = Match.order(params[:sort])
  end
  
  def new 
    @match = Match.new
  end
  
  def list
    @matches = current_user.player_one + current_user.player_two
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
  
  def destroy
      match = Match.find(params[:id])
      if match.destroy
        redirect_to :back, notice: 'Match deleted' 
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
    
    def set_tournament
      @tournament = Tournament.find(params[:tournament_id])
    end
    
    def sort_column
      Match.column_names.include?(params[:sort]) ? params[:sort] : "name"
    end
    
    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end
end