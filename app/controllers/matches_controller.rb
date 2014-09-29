class MatchesController < ApplicationController
  before_action :set_match, only: [:update, :delete]
  before_action :set_tournament, only: [:index, :show]
  load_and_authorize_resource skip_load_resource only: [:create] 
  helper_method :sort_column, :sort_direction

  def index
    @users = User.all
    @matches = @tournament.matches.all
  end
  
  def all
    @matches = Match.order(sort_column + " " + sort_direction)
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
      if @match.player_one!=@match.player_two && @match.save
        redirect_to :back, notice: 'Match was successfully created.' 
      else
         redirect_to :back, alert: "This is a versus game dude !"
      end
  end
  
  def update   
      if @match.update(score_params)
        respond_to do |format|
          format.html {redirect_to tournament_matches_path, :notice => 'Score was successfully updated.'}
          format.js
        end
      else
        respond_to do |format|
          format.html {redirect_to tournament_matches_path, :alert => "Score failed to update"}
          format.js {render "fail_update.js.erb"}
        end
      end
  end
  
  def destroy
      @match = Match.find(params[:id])
      if @match.destroy
        respond_to do |format|
          format.html {redirect_to tournament_matches_path, :notice => "Match deleted"}
          format.js
        end
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
      Match.column_names.include?(params[:sort]) ? params[:sort] : "id"
    end
    
    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end
end