class TournamentsController < ApplicationController
  
  def index
    @tournaments = Tournament.all
  end
  
  def new
    @tournament = Tournament.new
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
  
   protected 
   
    def tournament_params
      params.require(:tournament).permit(:name, :place, :max_player)
    end
  
end