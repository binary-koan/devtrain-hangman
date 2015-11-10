require_relative 'lib/controller'
require_relative 'lib/hangman'
require_relative 'lib/interface'

words = File.read('words.txt').split

game = Hangman.new(words.sample)
view = Interface.new(game)
Controller.new(game, view).play
