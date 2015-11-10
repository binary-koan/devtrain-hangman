require_relative '../lib/hangman'

RSpec.describe Hangman do
  let(:game) { Hangman.new }

  def guess_correctly(times)
    game.word.chars.first(times).each do |char|
      game.apply_guess(char)
    end
  end

  def guess_incorrectly(times)
    (('A'..'Z').to_a - game.word.chars).first(times).each do |char|
      game.apply_guess(char)
    end
  end

  describe '#in_progress?' do
    it 'should be true for a newly created game' do
      expect(game).to be_in_progress
    end

    it 'should be false when the game is won' do
      guess_correctly(game.word.length)
      expect(game).to_not be_in_progress
    end

    it 'should be false when the game is lost' do
      guess_incorrectly(Hangman::LIVES)
      expect(game).to_not be_in_progress
    end
  end

  describe '#incorrect_guesses' do
    it 'should initially be an empty' do
      expect(game.incorrect_guesses).to be_empty
    end

    it 'should remain empty when an invalid character is guessed' do
      game.apply_guess('1')
      expect(game.incorrect_guesses).to be_empty
    end

    it 'should be populated with incorrect letters' do
      guess_incorrectly(2)
      expect(game.incorrect_guesses.size).to eq 2
    end

    it 'should not be populated with correct letters' do
      guess_correctly(2)
      expect(game.incorrect_guesses.size).to eq 0
    end
  end

  describe '#apply_guess' do
    it 'should add a valid guess to the set of guessed letters' do
      game.apply_guess('A')
      expect(game.guessed?('A')).to be_truthy
    end

    it 'should fail for strings longer than 1' do
      game.apply_guess('AB')
      expect(game.guessed?('AB')).to be_falsy
    end

    it 'should fail for non-alphabetical characters' do
      game.apply_guess('!')
      expect(game.guessed?('!')).to be_falsy
    end
  end
end
