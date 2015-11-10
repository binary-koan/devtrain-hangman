require_relative 'lib/controller'
require_relative 'lib/hangman'
require_relative 'lib/interface'

game = Hangman.new
view = Interface.new(game)
Controller.new(game, view).play
