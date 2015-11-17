class PickWord
  DICTIONARY = File.read(Rails.root.join("config/words.txt")).split

  def initialize
  end

  def call
    DICTIONARY.sample
  end
end
