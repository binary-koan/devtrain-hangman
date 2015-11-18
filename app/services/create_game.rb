class CreateGame
  DICTIONARY = File.read(Rails.root.join("config/words.txt")).split

  def initialize
  end

  def call
    Game.create!(target_word: DICTIONARY.sample)
  end
end
