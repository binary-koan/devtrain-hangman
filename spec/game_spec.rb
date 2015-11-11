require_relative 'spec_helper'

RSpec.describe Game do
  let(:word) { "test" }
  let(:game) { Game.new(word) }

  def win_game
    guess_correctly(word.length)
  end

  def lose_game
    guess_incorrectly(Game::MAX_LIVES)
  end

  def guess_correctly(times)
    word.upcase.chars.first(times).each do |char|
      game.apply_guess(char)
    end
  end

  def guess_incorrectly(times)
    (('A'..'Z').to_a - word.upcase.chars).first(times).each do |char|
      game.apply_guess(char)
    end
  end

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
    let(:word) { "guessword" }

    it "is true for letters which have been guessed correctly" do
      game.apply_guess("G")
      expect(game).to be_guessed("G")
    end

    it "is true for letters which have been guessed incorrectly" do
      game.apply_guess("A")
      expect(game).to be_guessed("A")
    end

    it "is false for letters which have not been guessed" do
      game.apply_guess("A")
      expect(game).not_to be_guessed("X")
    end

    it "is false for invalid guesses" do
      game.apply_guess("ABC")
      expect(game).not_to be_guessed("ABC")
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
    let(:word) { "applying" }

    it "succeeds when guessing a letter from the word" do
      expect(game.apply_guess("A")).to be_truthy
    end

    it "succeeds when guessing a letter which isn't in the word" do
      expect(game.apply_guess("Z")).to be_truthy
    end

    it "fails when guessing the same letter twice" do
      expect(game.apply_guess("A")).to be_truthy
      expect(game.apply_guess("A")).to be_falsy
    end

    it "fails with an empty string" do
      expect(game.apply_guess("")).to be_falsy
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
