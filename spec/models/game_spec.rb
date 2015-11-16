require 'rails_helper'

RSpec.describe Game, type: :model do
  subject(:game) { Game.new }

  describe "#target_word" do
    it "is generated on save" do
      game.save!
      expect(game.target_word).not_to be_nil
    end

    it "is not regenerated on subsequent saves" do
      game.save!
      word = game.target_word

      game.guesses.create!(guessed_letter: "a")
      game.save!

      expect(game.target_word).to eq word
    end

    it "can be set explicitly" do
      game.target_word = "notactuallyaword"
      game.save!
      expect(game.target_word).to eq "notactuallyaword"
    end
  end

  describe "#guesses" do
    it "is initially empty" do
      expect(game.guesses).to be_empty
    end

    it "adds guesses referencing the game" do
      game.save!
      guess = game.guesses.create!(guessed_letter: "a")
      expect(guess.game).to eq game
    end
  end
end
