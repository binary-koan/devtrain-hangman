require_relative 'spec_helper'

RSpec.describe Interface do
  include SpecHelper

  let(:incorrect_guesses) { Set.new }
  let(:game) do
    instance_double(Game,
      word: "TEST",
      guessed?: false,
      incorrect_guesses: incorrect_guesses)
  end

  let(:view) { Interface.new(game) }

  before do
    allow(view).to receive(:puts)
    allow(view).to receive(:gets).and_return("\n")
  end

  describe "#print_game_state" do
    context "when no letters have been guessed" do
      it "prints the target word as underscores" do
        expect(view).to receive(:puts).with(/____/)
        view.print_game_state
      end
    end

    context "when correct letters have been guessed" do
      it "prints the target word with letters and underscores" do
        expect(game).to receive(:guessed?).and_return(true, true, false)
        expect(view).to receive(:puts).with(/TE__/)
        view.print_game_state
      end
    end

    context "when incorrect letters have been guessed" do
      let(:incorrect_guesses) { Set.new(["A", "B"]) }

      it "prints the number of incorrect guesses" do
        expect(view).to receive(:puts).with(/2 letters incorrect/)
        view.print_game_state
      end

      it "prints a list of incorrect guesses" do
        expect(view).to receive(:puts).with(/A B/)
        view.print_game_state
      end
    end
  end

  describe "#ask_for_guess" do
    it "prints a message asking for a guess" do
      expect(view).to receive(:print).with("What's your next guess? ")
      view.ask_for_guess
    end

    it "gets a line of input" do
      expect(view).to receive(:gets).and_return("A\n")
      expect(view.ask_for_guess).to eq "A"
    end

    it "makes input uppercase" do
      expect(view).to receive(:gets).and_return("iNpUt\n")
      expect(view.ask_for_guess).to eq "INPUT"
    end
  end

  describe "#print_game_result" do
    context "when the game is won" do
      before do
        allow(game).to receive(:won?).and_return(true)
      end

      it "displays a success message" do
        expect(view).to receive(:puts).with('Well done!')
        view.print_game_result
      end

      it "displays the word" do
        expect(view).to receive(:puts).with(/TEST/)
        view.print_game_result
      end
    end

    context "when the game is not won" do
      before do
        allow(game).to receive(:won?).and_return(false)
      end

      it "displays a failure message" do
        expect(view).to receive(:puts).with "Better luck next time ..."
        allow(view).to receive(:puts)
        view.print_game_result
      end

      it "displays the word" do
        allow(view).to receive(:puts)
        expect(view).to receive(:puts).with(/TEST/)
        view.print_game_result
      end
    end
  end

  describe "#print_error" do
    it "displays the given error message" do
      error = 'test'
      expect(view).to receive(:puts).with(error)
      view.print_error(error)
    end
  end
end
