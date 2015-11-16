class Game < ActiveRecord::Base
  DICTIONARY = File.read(Rails.root.join("config/words.txt")).split
  MAX_LIVES = 8

  has_many :guesses

  validates :target_word, presence: true
  before_validation :generate_target

  def won?
    (target_word.chars - guessed_letters).empty?
  end

  def lost?
    incorrect_guesses.size >= MAX_LIVES
  end

  def guessed_letters
    guesses.map(&:guessed_letter)
  end

  def incorrect_guesses
    guessed_letters - target_word.chars
  end

  private

  def generate_target
    self.target_word ||= DICTIONARY.sample
  end
end
