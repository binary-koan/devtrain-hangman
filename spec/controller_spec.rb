require_relative '../lib/controller'
require_relative '../lib/hangman'
require_relative '../lib/interface'

describe Controller do
  let(:game) { instance_double(Hangman) }
  let(:view) { instance_double(Interface) }
  let(:controller) { Controller.new(game, view) }

  describe '#play' do
    it 'prints the result when the game is finished' do
      expect(game).to receive(:in_progress?).and_return(false)
      expect(view).to receive(:print_game_result)
      controller.play
    end

    it 'prints the game state if the game is not finished' do
      expect(game).to receive(:in_progress?).and_return(true, false)
      expect(view).to receive(:print_game_state)

      allow(view).to receive(:ask_for_guess)
      allow(game).to receive(:apply_guess).and_return(true)
      allow(view).to receive(:print_game_result)

      controller.play
    end

    it 'prints the game state each turn until the game is finished' do
      expect(game).to receive(:in_progress?).and_return(true, true, true, false)
      expect(view).to receive(:print_game_state).at_least(3).times

      allow(view).to receive(:ask_for_guess)
      allow(game).to receive(:apply_guess).and_return(true)
      allow(view).to receive(:print_game_result)

      controller.play
    end
  end
end
