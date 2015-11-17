require 'rails_helper'

RSpec.describe Game, type: :model do
  let(:target_word) { "test" }
  subject(:game) { Game.create!(target_word: target_word) }

  def guess(*letters)
    letters.each { |letter| game.guesses.create!(guessed_letter: letter) }
  end

  def win_game
    guess(*target_word.chars.uniq)
  end

  def lose_game
    incorrect_chars = ("a".."z").to_a - target_word.chars
    guess(*(incorrect_chars.first(Game::MAX_LIVES)))
  end

  describe "#target_word" do
    context "when unspecified" do
      let(:target_word) { nil }

      it "is generated on save" do
        expect(game.target_word).not_to be_nil
      end

      it "is not regenerated on subsequent saves" do
        word = game.target_word
        game.save!
        expect(game.target_word).to eq word
      end
    end

    context "when set explicitly" do
      let(:target_word) { "notactuallyaword" }

      it "is saved as set" do
        expect(game.target_word).to eq "notactuallyaword"
      end
    end
  end

  describe "#guesses" do
    it "is initially empty" do
      expect(game.guesses).to be_empty
    end

    it "adds guesses referencing the game" do
      guess = game.guesses.create!(guessed_letter: "a")
      expect(guess.game).to eq game
    end
  end

  describe "#won?" do
    let(:target_word) { "croc" }
    subject { game.won? }

    context "at the start of the game" do
      it { is_expected.to eq false }
    end

    context "when all letters in the word have been guessed" do
      before { win_game }
      it { is_expected.to eq true }
    end
  end

  describe "#lost?" do
    let(:target_word) { "z" }
    subject { game.lost? }

    context "at the start of the game" do
      it { is_expected.to eq false }
    end

    context "when there are too many incorrect guesses" do
      before { lose_game }
      it { is_expected.to eq true }
    end
  end

  describe "#guessed?" do
    let(:target_word) { "longword" }
    before { guess("l", "q", "w", "z") }

    it "is true for correctly guessed letters" do
      expect(game).to be_guessed("l")
      expect(game).to be_guessed("w")
    end

    it "is true for incorrectly guessed letters" do
      expect(game).to be_guessed("q")
      expect(game).to be_guessed("z")
    end

    it "is false for letters which have not been guessed" do
      expect(game).not_to be_guessed("o")
      expect(game).not_to be_guessed("y")
    end
  end

  describe "#incorrect_guesses" do
    let(:target_word) { "incorrect" }
    before { guess("i", "q", "c", "z") }

    it "contains incorrectly guessed letters" do
      expect(game.incorrect_guesses).to include "q"
      expect(game.incorrect_guesses).to include "z"
    end

    it "does not contain correctly guessed letters" do
      expect(game.incorrect_guesses).not_to include "i"
      expect(game.incorrect_guesses).not_to include "c"
    end

    it "does not contain letters which haven't been guessed" do
      expect(game.incorrect_guesses).not_to include "a"
      expect(game.incorrect_guesses).not_to include "b"
    end
  end

  describe "#masked_word" do
    let(:target_word) { "test" }

    subject { game.masked_word }

    context "when no letters have been guessed" do
      it { is_expected.to eq [nil, nil, nil, nil] }
    end

    context "when letters have been guessed incorrectly" do
      before { guess("q", "z") }
      it { is_expected.to eq [nil, nil, nil, nil] }
    end

    context "when some letters have been guessed" do
      before { guess("t", "s") }
      it { is_expected.to eq ["t", nil, "s", "t"] }
    end

    context "when all letters have been guessed" do
      before { win_game }
      it { is_expected.to eq ["t", "e", "s", "t"] }
    end
  end
end
