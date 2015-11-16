require 'rails_helper'

RSpec.describe Game, type: :model do
  let(:target_word) { "test" }
  subject(:game) { Game.create!(target_word: target_word) }

  def guess(*letters)
    letters.each { |letter| game.guesses.create!(guessed_letter: letter) }
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

    it "is false at the start of the game" do
      expect(game).not_to be_won
    end

    it "is true when all letters in the word have been guessed" do
      guess("c", "o", "r")
      expect(game).to be_won
    end
  end
end
