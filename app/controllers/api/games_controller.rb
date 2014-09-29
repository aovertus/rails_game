class API::GamesController < ApplicationController
  before_action :authenticate
  
  def index
    @games = Game.all
    respond_to do |format|
      format.json { render :json => @games }
    end

  end

end