require 'simplecov'
SimpleCov.start do
  add_filter '/spec/'
end

require_relative '../lib/controller'
require_relative '../lib/game'
require_relative '../lib/interface'

module SpecHelper
  def win_game
    guess_correctly(game.word.length)
  end

  def lose_game
    guess_incorrectly(Game::LIVES)
  end

  def guess_correctly(times)
    game.word.chars.first(times).each do |char|
      game.apply_guess(char)
    end
  end

  def guess_incorrectly(times)
    (('A'..'Z').to_a - game.word.chars).first(times).each do |char|
      game.apply_guess(char)
    end
  end
end
