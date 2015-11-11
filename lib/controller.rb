class Controller
  def initialize(game, view)
    @game = game
    @view = view
  end

  def play
    play_turn while @game.in_progress?
    @view.print_game_result
  end

  private

  def play_turn
    @view.print_game_state
    @game.apply_guess(@view.ask_for_guess)
  end
end
