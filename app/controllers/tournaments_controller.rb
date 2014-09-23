class TournamentsController < ApplicationController
  before_action :set_tournament, only: [:show, :edit, :update, :destroy, :register]
  before_action :set_games #, only: [:show, :edit, :update, :new]
  load_and_authorize_resource
  def index
    @tournaments = Tournament.all
  end
  
  def show
  end
  
  def update
    respond_to do |format|
      if @tournament.update(tournament_params)
        format.html { redirect_to tournaments_path, notice: 'Tournament was successfully updated.' }
        format.json { render :show, status: :ok, location: @tournament }
      else
        format.html { render :edit }
        format.json { render json: @tournament.errors, status: :unprocessable_entity }
      end
   end
  end
  
  def ranking
    @tournaments = Tournament.all
  end

  def register
    if @tournament.can_subscribe?(@tournament, current_user)
       if @tournament.users.push(current_user)
          redirect_to tournament_path(@tournament), notice: 'Subscription done !'
       else
         redirect_to tournament_path(@tournament), alert: "Subscription failed !"
      end
    else 
      redirect_to tournament_path(@tournament), alert: "We've reach the number of participants max !"
    end
  end
  
  def new
    @tournament = Tournament.new()
  end
  
  def create
    @tournament = Tournament.new(tournament_params)
    @tournament.user = current_user #should be current_user.tournaments.new(tournament_params)
    params[:tournament_game][:game_id].reject! { |game| game.empty? }
    @tournament.games.push(Game.find(params[:tournament_game][:game_id]))
    @tournament.users.push(current_user) 
    respond_to do |format| 
      if @tournament.games.any? && @tournament.save
        format.html { redirect_to @tournament, notice: 'Tournament was successfully created.' }
        format.json { render :show, status: :created, location: @tournament }
      else
        format.html { redirect_to new_tournament_path, alert: "Unable to save, make sure you checked one or more games" }
        format.json { render json: @tournament.errors, status: :unprocessable_entity }
      end
    end
  end
  
   private
    def set_tournament
      @tournament = Tournament.find(params[:id])
    end
   
   def set_games
     @games = Game.all
   end
   
    def tournament_params
      params.require(:tournament).permit(:name, :start_at, :end_at, :address, :longitude, :latitude, :max_player,
        :games_attributes => [:id])
      
    end
  
end