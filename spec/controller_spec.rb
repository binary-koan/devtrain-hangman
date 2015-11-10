require_relative 'spec_helper'

RSpec.describe Controller do
  let(:game) {
    instance_double(Game,
      apply_guess: true)
  }
  let(:view) {
    instance_double(Interface,
      print_game_state: nil,
      print_game_result: nil,
      ask_for_guess: nil)
  }
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
      controller.play
    end

    it 'prints the game state each turn until the game is finished' do
      expect(game).to receive(:in_progress?).and_return(true, true, true, false)
      expect(view).to receive(:print_game_state).exactly(3).times
      controller.play
    end

    it 'asks for guesses until the game is finished' do
      expect(game).to receive(:in_progress?).and_return(true, true, false)
      expect(view).to receive(:ask_for_guess).exactly(2).times
      controller.play
    end

    it 'applies guesses it receives to the game' do
      expect(game).to receive(:in_progress?).and_return(true, false)
      expect(view).to receive(:ask_for_guess).and_return('guess')
      expect(game).to receive(:apply_guess).with('guess')
      controller.play
    end

    it 'prints an error if a guess is invalid' do
      expect(game).to receive(:in_progress?).and_return(true, false)
      expect(game).to receive(:apply_guess).and_return(false)
      expect(view).to receive(:print_error)
      controller.play
    end
  end
end
