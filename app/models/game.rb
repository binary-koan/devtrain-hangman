class Game < ActiveRecord::Base
  MAX_LIVES = 8

  has_many :guesses

  before_validation :generate_target
  validates :target_word, presence: true

  def won?
    (target_word.chars - guessed_letters).empty?
  end

  def lost?
    incorrect_guesses.size >= MAX_LIVES
  end

  def finished?
    won? || lost?
  end

  def guessed?(char)
    guessed_letters.include?(char)
  end

  def incorrect_guesses
    guessed_letters - target_word.chars
  end

  def masked_word
    target_word.chars.map { |char| char if guessed?(char) }
  end

  def guessed_letters
    guesses.map(&:guessed_letter)
  end

  private

  def generate_target
    self.target_word ||= PickWord.new.call
  end
end
