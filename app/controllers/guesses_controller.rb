class GuessesController < ApplicationController
  def create
    game = Game.find(params[:game_id])
    submission = SubmitGuess.call(game, guess_params)

    flash.alert = submission.errors if submission.errors
    redirect_to game
  end

  private

  def guess_params
    params.require(:guess).permit(:guessed_letter)
  end
end
