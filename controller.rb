require_relative 'hangman'
require_relative 'interface'

class Controller
  def initialize
    @game = Hangman.new
    @view = Interface.new(@game)
  end

  def play
    play_turn while @game.in_progress?
    @view.print_game_result
  end

  def play_turn
    @view.print_game_state
    get_new_guess
  end

  def get_new_guess
    until @game.apply_guess(@view.ask_for_guess)
      @view.print_error "You need to guess a single letter which you haven't tried before!"
    end
  end
end

Controller.new.play
