require_relative 'spec_helper'

RSpec.describe Game do
  include SpecHelper

  let(:game) { Game.new('test') }

  describe "#in_progress?" do
    subject { game.in_progress? }

    context "for a newly created game" do
      it { is_expected.to be true }
    end

    context "when the game is won" do
      before { win_game }
      it { is_expected.to be false }
    end

    context "when the game is lost" do
      before { lose_game }
      it { is_expected.to be false }
    end
  end

  describe "#guessed?" do
    it "is false for invalid guesses" do
      game.apply_guess("ABC")
      expect(game).not_to be_guessed("ABC")
    end

    it "is false for letters which have not been guessed" do
      game.apply_guess("B")
      expect(game).not_to be_guessed("A")
    end

    it 'is true for letters which have been guessed correctly' do
      guesses = guess_correctly(1)
      expect(game).to be_guessed(guesses[0])
    end

    it 'is true for letters which have been guessed incorrectly' do
      guesses = guess_incorrectly(1)
      expect(game).to be_guessed(guesses[0])
    end
  end

  describe '#incorrect_guesses' do
    subject { game.incorrect_guesses }

    context "for a newly created game" do
      it { is_expected.to be_empty }
    end

    context "when an invalid character has been guessed" do
      before { game.apply_guess('1') }
      it { is_expected.to be_empty }
    end

    context "when incorrect letters have been guessed" do
      before { guess_incorrectly(2) }

      it "should contain the guessed letters" do
        expect(subject.length).to eq 2
      end
    end

    context "when correct letters have been guessed" do
      before { guess_correctly(2) }

      it "should not contain the guessed letters" do
        expect(subject.length).to eq 0
      end
    end
  end

  describe "#apply_guess" do
    it "succeeds when guessing a letter from the word" do
      expect(game.apply_guess("T")).to be_truthy
    end

    it "succeeds when guessing a letter which isn't in the word" do
      expect(game.apply_guess("A")).to be_truthy
    end

    it "fails when guessing the same letter twice" do
      expect(game.apply_guess("A")).to be_truthy
      expect(game.apply_guess("A")).to be_falsy
    end

    it "fails for lowercase letters" do
      expect(game.apply_guess("a")).to be_falsy
    end

    it "fails for strings longer than 1" do
      expect(game.apply_guess("AB")).to be_falsy
    end

    it "fails for non-alphabetical characters" do
      expect(game.apply_guess("!")).to be_falsy
    end
  end
end
