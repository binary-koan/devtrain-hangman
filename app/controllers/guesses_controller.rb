class GuessesController < ApplicationController
  before_action :assign_game

  def create
    submission = SubmitGuess.new(@game, guess_params[:guessed_letter])

    unless submission.call
      flash.alert = submission.errors
    end
    redirect_to @game
  end

  private

  def assign_game
    @game = Game.find(params[:game_id])
  end

  def guess_params
    params.require(:guess).permit(:guessed_letter)
  end
end
