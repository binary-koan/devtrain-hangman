class Game < ActiveRecord::Base
  DICTIONARY = File.read(Rails.root.join("config/words.txt")).split

  validates_presence_of :target_word
  before_validation :generate_target

  private

  def generate_target
    self.target_word ||= DICTIONARY.sample
  end
end
