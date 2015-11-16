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

    it "prevents adding guesses with the same letter" do
      game.guesses.create!(guessed_letter: "a")
      guess = game.guesses.new(guessed_letter: "a")
      expect(guess.save).to eq false
    end

    it "prevents adding guesses when the game is won" do
      win_game
      guess = game.guesses.new(guessed_letter: "z")
      expect(guess.save).to eq false
    end

    it "prevents adding guesses when the game is lost" do
      lose_game
      guess = game.guesses.new(guessed_letter: "z")
      expect(guess.save).to eq false
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
end
