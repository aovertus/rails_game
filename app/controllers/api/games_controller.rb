class API::GamesController < ApplicationController
  before_action :authenticate
  
  def index
    @games = Game.all
    render json: @games
  end

end