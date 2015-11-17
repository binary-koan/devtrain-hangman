class GuessesController < ApplicationController
  def create
    game = Game.find(params[:game_id])
    submission = SubmitGuess.new(game, guess_params)

    unless submission.call
      flash.alert = submission.errors
    end
    redirect_to game
  end

  private

  def guess_params
    params.require(:guess).permit(:guessed_letter)
  end
end
