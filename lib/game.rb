require 'set'

class Game
  MAX_LIVES = 8

  attr_reader :word

  def initialize(word)
    @word = word.upcase
    @guessed_letters = Set.new
  end

  def in_progress?
    !finished?
  end

  def finished?
    won? || lost?
  end

  def won?
    @guessed_letters.superset?(@word.chars.to_set)
  end

  def lost?
    incorrect_guesses.size >= MAX_LIVES
  end

  def guessed?(char)
    @guessed_letters.include?(char)
  end

  def incorrect_guesses
    @guessed_letters - @word.chars
  end

  def apply_guess(guess)
    @guessed_letters.add(guess) if valid_guess?(guess)
  end

  private

  def valid_guess?(guess)
    guess =~ /\A[A-Z]\z/ && !@guessed_letters.include?(guess)
  end
end