class GuessesController < ApplicationController
  def create
    @game = Game.find(params[:game_id])
    @guess = @game.guesses.new(guess_params)

    unless @guess.save
      flash.alert = @guess.errors.full_messages.first
    end

    redirect_to @game
  end

  private

  def guess_params
    params.require(:guess).permit(:guessed_letter)
  end
end
