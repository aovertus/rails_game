class API::GamesController < ApplicationController
  before_action :authenticate
  TOKEN = "railsgames"

  def index
    @games = Game.all
    render json: @games, status: 200
  end

  def update
    game = Game.find(params[:id])
    game.title = params[:title]
    game.save!
    render json: game, status: 200
    # game.update(game_params)
    # render json: game, status: 200
   end

  def show
    game = Game.find(params[:id])
    render json: game, status: 200
  end


  private


    def authenticate
      authenticate_or_request_with_http_token do |token, options|
        token == TOKEN
      end
    end

    def game_params
      params.require(:game).permit(:title, :note, :image)
    end
end

