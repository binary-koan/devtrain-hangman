class SubmitGuess
  def self.call(game, params)
    new(game, params).tap { |submission| submission.call }
  end

  attr_reader :errors

  def initialize(game, params)
    @game = game
    @guessed_letter = params[:guessed_letter]
  end

  def call
    if @game.finished?
      @errors = ["You can't add a guess to a game which is already finished"]
    elsif @game.guessed?(@guessed_letter)
      @errors = ["You can't guess the same letter twice"]
    else
      apply_guess
    end
  end

  private

  def apply_guess
    guess = @game.guesses.new(guessed_letter: @guessed_letter)
    unless guess.save
      @errors = guess.errors.full_messages
    end
  end
end
