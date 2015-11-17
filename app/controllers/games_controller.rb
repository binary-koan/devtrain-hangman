class GamesController < ApplicationController
  def new
    @game = Game.new
  end

  def create
    @game = Game.new

    if @game.save
      redirect_to @game
    else
      redirect_to new_game_url
    end
  end

  def show
    @game = Game.find(params[:id])
  end
end
