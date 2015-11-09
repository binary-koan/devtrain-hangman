class HangmanGame
  WORDS = File.read('words.txt').split("\n")
  LIVES = 8

  attr_reader :word

  def initialize
    @word = WORDS.sample.upcase
    @guessed_letters = []
  end

  def in_progress?
    !won? && !lost?
  end

  def won?
    (@word.chars - @guessed_letters).empty?
  end

  def lost?
    incorrect_guess_count >= LIVES
  end

  def word_with_blanks
    @word.chars.map { |char| @guessed_letters.include?(char) ? char : '_' }
  end

  def incorrect_guess_count
    (@guessed_letters - @word.chars).size
  end

  def apply_guess(guess)
    @guessed_letters.push(guess) if valid_guess?(guess)
  end

  private

  def valid_guess?(guess)
    guess =~ /^[A-Z]$/ && !@guessed_letters.include?(guess)
  end
end
