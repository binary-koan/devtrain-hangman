require_relative '../lib/hangman'
require_relative '../lib/interface'
require_relative 'spec_helper'

RSpec.describe Interface do
  include SpecHelper

  let(:game) { Hangman.new }
  let(:view) { Interface.new(game) }

  describe '#print_game_state' do
    it 'initially prints the target word as underscores' do
      allow(view).to receive(:print)
      expect(view).to receive(:puts).with('_' * game.word.length)
      view.print_game_state
    end

    it 'prints the target word with letters when letters have been guessed' do
      allow(view).to receive(:print)
      expect(view).to receive(:puts).with(/[A-Z_]+/)
      view.print_game_state
    end

    it 'prints the number of incorrect guesses' do
      guess_incorrectly(2)
      allow(view).to receive(:print)
      allow(view).to receive(:puts)
      expect(view).to receive(:print).with(/2 letters incorrect/)
      expect(view).to receive(:puts).with(/[A-Z] [A-Z]/)
      view.print_game_state
    end
  end

  describe '#ask_for_guess' do
    it 'prints a message asking for a guess' do
      expect(view).to receive(:print).with("What's your next guess? ")
      allow(view).to receive(:gets).and_return('')
      view.ask_for_guess
    end

    it 'gets a line of input' do
      allow(view).to receive(:print)
      expect(view).to receive(:gets).and_return("A\n")
      expect(view.ask_for_guess).to eq 'A'
    end

    it 'makes input uppercase' do
      allow(view).to receive(:print)
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
