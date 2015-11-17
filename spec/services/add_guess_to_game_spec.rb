describe SubmitGuess do
  let(:game) { Game.create! }
  let(:guessed_letter) { "a" }

  subject(:result) { SubmitGuess.call(game, guessed_letter: guessed_letter) }

  describe "#call" do
    it "succeeds with a blank game" do
      expect(result.errors).to be_nil
    end

    it "fails if the game is finished" do
      expect(game).to receive(:finished?).and_return(true)
      expect(result.errors).to include "You can't add a guess to a game which is already finished"
    end

    it "fails if the letter has already been guessed" do
      expect(game).to receive(:guessed?).with("a").and_return(true)
      expect(result.errors).to include "You can't guess the same letter twice"
    end

    context "with an invalid guess" do
      let(:guessed_letter) { "?" }

      it "fails" do
        expect(result.errors).to include "Guessed letter must be one lowercase letter"
      end
    end
  end

end
