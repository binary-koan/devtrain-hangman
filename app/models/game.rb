class Game < ActiveRecord::Base
  DICTIONARY = File.read(Rails.root.join("config/words.txt")).split

  has_many :guesses

  validates :target_word, presence: true
  before_validation :generate_target

  private

  def generate_target
    self.target_word ||= DICTIONARY.sample
  end
end
