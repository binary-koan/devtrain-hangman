require_relative 'spec_helper'

RSpec.describe Interface do
  let(:incorrect_guesses) { Set.new }
  let(:game) do
    instance_double(Game,
      word: "TEST",
      guessed?: false,
      incorrect_guesses: incorrect_guesses)
  end

  let(:view) { Interface.new(game) }

  before do
    allow(view).to receive(:print)
    allow(view).to receive(:puts)
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

  describe "#process_next_guess" do
    it "prints a message asking for a guess" do
      expect(view).to receive(:gets).and_return("\n")
      allow(game).to receive(:apply_guess).and_return(true)
      expect(view).to receive(:print).with(/What's your next guess?/)
      view.process_next_guess
    end

    it "sends input to the game" do
      expect(view).to receive(:gets).and_return("A\n")
      expect(game).to receive(:apply_guess).with("A").and_return(true)
      view.process_next_guess
    end

    it "makes input uppercase" do
      expect(view).to receive(:gets).and_return("iNpUt\n")
      expect(game).to receive(:apply_guess).with("INPUT").and_return(true)
      view.process_next_guess
    end

    it "prints an error if a guess is invalid" do
      expect(view).to receive(:gets).at_least(:once).and_return("\n")
      expect(game).to receive(:apply_guess).and_return(false, true)
      expect(view).to receive(:puts).with(
        /You need to guess a single letter which you haven't tried before!/
      )
      view.process_next_guess
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
        expect(view).to receive(:puts).with(/Better luck next time .../)
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
end
