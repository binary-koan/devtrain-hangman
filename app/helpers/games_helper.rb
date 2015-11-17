module GamesHelper
  POSSIBLE_GUESSES = ("a".."z").to_a

  def valid_guesses(game)
    POSSIBLE_GUESSES - game.guessed_letters
  end
end
