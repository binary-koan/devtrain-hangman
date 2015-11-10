require_relative 'spec_helper'

RSpec.describe Game do
  include SpecHelper

  let(:game) { Game.new('test') }

  describe '#in_progress?' do
    it 'should be true for a newly created game' do
      expect(game).to be_in_progress
    end

    it 'should be false when the game is won' do
      win_game
      expect(game).to be_won
      expect(game).not_to be_in_progress
    end

    it 'should be false when the game is lost' do
      lose_game
      expect(game).to be_lost
      expect(game).not_to be_in_progress
    end
  end

  describe '#guessed?' do
    it 'should be false for invalid guesses' do
      game.apply_guess('ABC')
      expect(game).not_to be_guessed('ABC')
    end

    it 'should be false for letters which have not been guessed' do
      game.apply_guess('B')
      expect(game).not_to be_guessed('A')
    end

    it 'should be true for letters which have been guessed correctly' do
      guesses = guess_correctly(1)
      expect(game).to be_guessed(guesses[0])
    end

    it 'should be true for letters which have been guessed incorrectly' do
      guesses = guess_incorrectly(1)
      expect(game).to be_guessed(guesses[0])
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
    it 'should succeed for letters in the word' do
      expect(game.apply_guess('T')).to be_truthy
    end

    it 'should succeed for letters not in the word' do
      expect(game.apply_guess('A')).to be_truthy
    end

    it 'should fail when guessing the same letter twice' do
      expect(game.apply_guess('A')).to be_truthy
      expect(game.apply_guess('A')).to be_falsy
    end

    it 'should fail for lowercase letters' do
      expect(game.apply_guess('a')).to be_falsy
    end

    it 'should fail for strings longer than 1' do
      expect(game.apply_guess('AB')).to be_falsy
    end

    it 'should fail for non-alphabetical characters' do
      expect(game.apply_guess('!')).to be_falsy
    end
  end
end
