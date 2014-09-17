class TournamentsController < ApplicationController
  before_action :set_game, only: [:show, :edit, :update, :destroy]
  
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

  
  def new
    @tournament = Tournament.new
    @games = Game.all
  end
  
  def create
    @tournament = Tournament.new(tournament_params)
    respond_to do |format|
      if @tournament.save
        format.html { redirect_to @tournament, notice: 'Tournament was successfully created.' }
        format.json { render :show, status: :created, location: @tournament }
      else
        format.html { render :new }
        format.json { render json: @tournament.errors, status: :unprocessable_entity }
      end
    end
  end
  
   private
    def set_game
      @tournament = Tournament.find(params[:id])
    end
   
    def tournament_params
      params.require(:tournament).permit(:name, :start_at, :end_at, :address, :longitude, :latitude, :max_player,
        :games_attributes => [:id, :title])
    end
  
end