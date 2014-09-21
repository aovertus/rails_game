class MatchsController < ApplicationController
  def index
    @tournament = Tournament.find(params[:tournament_id])
  end
end