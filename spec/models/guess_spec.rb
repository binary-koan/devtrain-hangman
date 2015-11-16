require 'rails_helper'

RSpec.describe Guess, type: :model do
  let(:game) { Game.create! }
  subject(:guess) { game.guesses.new }

  describe "#guessed_letter" do
    it "is required" do
      expect(guess).not_to be_valid
      guess.guessed_letter = "a"
      expect(guess).to be_valid
    end

    it "cannot be empty" do
      guess.guessed_letter = ""
      expect(guess).not_to be_valid
    end

    it "cannot be more than one letter" do
      guess.guessed_letter = "ab"
      expect(guess).not_to be_valid
    end

    it "cannot be an uppercase letter" do
      guess.guessed_letter = "A"
      expect(guess).not_to be_valid
    end
  end
end
