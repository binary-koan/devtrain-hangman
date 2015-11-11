require_relative 'spec_helper'

RSpec.describe Controller do
  let(:game) do
    instance_double(Game,
      apply_guess: true)
  end
  let(:view) do
    instance_double(Interface,
      print_game_state: nil,
      print_game_result: nil,
      process_next_guess: false)
  end
  let(:controller) { Controller.new(game, view) }

  describe "#play" do
    it "prints the result when the game is finished" do
      expect(game).to receive(:in_progress?).and_return(false)
      expect(view).to receive(:print_game_result)
      controller.play
    end

    it "prints the game state each turn until the game is finished" do
      expect(game).to receive(:in_progress?).and_return(true, true, true, false)
      expect(view).to receive(:print_game_state).exactly(3).times
      controller.play
    end

    it "asks for guesses until the game is finished" do
      expect(game).to receive(:in_progress?).and_return(true, true, false)
      expect(view).to receive(:process_next_guess).exactly(2).times
      controller.play
    end
  end
end
