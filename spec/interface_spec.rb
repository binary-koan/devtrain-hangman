require_relative 'spec_helper'

RSpec.describe Interface do
  include SpecHelper

  let(:game) { Game.new('test') }
  let(:view) { Interface.new(game) }

  before do
    allow(view).to receive(:print)
    allow(view).to receive(:puts)
    allow(view).to receive(:gets).and_return("\n")
  end

  describe '#print_game_state' do
    it 'initially prints the target word as underscores' do
      expect(view).to receive(:puts).with('_' * game.word.length)
      view.print_game_state
    end

    it 'prints the target word with letters when letters have been guessed' do
      game.apply_guess('T')
      game.apply_guess('E')
      expect(view).to receive(:puts).with('TE_T')
      view.print_game_state
    end

    it 'prints the number of incorrect guesses' do
      guesses = guess_incorrectly(2)
      expect(view).to receive(:print).with(/2 letters incorrect/)
      expect(view).to receive(:puts).with("#{guesses[0]} #{guesses[1]}")
      view.print_game_state
    end
  end

  describe '#ask_for_guess' do
    it 'prints a message asking for a guess' do
      expect(view).to receive(:print).with("What's your next guess? ")
      view.ask_for_guess
    end

    it 'gets a line of input' do
      expect(view).to receive(:gets).and_return("A\n")
      expect(view.ask_for_guess).to eq 'A'
    end

    it 'makes input uppercase' do
      expect(view).to receive(:gets).and_return("iNpUt\n")
      expect(view.ask_for_guess).to eq 'INPUT'
    end
  end

  describe '#print_game_result' do
    def game_word_pattern
      Regexp.new(Regexp.escape(game.word))
    end

    it 'displays a success message if the game was won' do
      win_game
      expect(view).to receive(:puts).with('Well done!')
      allow(view).to receive(:puts)
      view.print_game_result
    end

    it 'displays the word if the game was won' do
      win_game
      allow(view).to receive(:puts)
      expect(view).to receive(:puts).with(game_word_pattern)
      view.print_game_result
    end

    it 'displays a failure message if the game was not won' do
      expect(view).to receive(:puts).with 'Better luck next time ...'
      allow(view).to receive(:puts)
      view.print_game_result
    end

    it 'displays the word if the game was not won' do
      win_game
      allow(view).to receive(:puts)
      expect(view).to receive(:puts).with(game_word_pattern)
      view.print_game_result
    end
  end

  describe '#print_error' do
    it 'displays the given error message' do
      error = 'test'
      expect(view).to receive(:puts).with(error)
      view.print_error(error)
    end
  end
end
