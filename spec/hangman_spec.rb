require_relative '../lib/hangman'
require_relative 'spec_helper'

RSpec.describe Hangman do
  include SpecHelper

  let(:game) { Hangman.new }

  describe '#in_progress?' do
    it 'should be true for a newly created game' do
      expect(game).to be_in_progress
    end

    it 'should be false when the game is won' do
      win_game
      expect(game).to be_won
      expect(game).to_not be_in_progress
    end

    it 'should be false when the game is lost' do
      lose_game
      expect(game).to be_lost
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
