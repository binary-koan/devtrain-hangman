require_relative 'game'

class HangmanCLI
  def initialize
    @game = HangmanGame.new
  end

  def play
    play_turn while @game.in_progress?
    print_game_result
  end

  private

  def play_turn
    print_game_state
    guess = ask_for_guess
    @game.apply_guess(guess)
  end

  def print_game_state
    print "I'm thinking of a word like "
    puts @game.word_with_blanks.map { |char| char || '_' }.join
    puts "So far, you've made #{@game.incorrect_guess_count} incorrect guesses."
  end

  def ask_for_guess
    loop do
      print "What's your next guess? "
      guess = gets.chomp.upcase
      return guess if @game.valid_guess?(guess)

      puts "You need to guess a single letter which you haven't tried before!"
    end
  end

  def print_game_result
    if @game.won?
      puts 'Well done!'
      puts "The word was indeed #{@game.word}."
    else
      puts 'Better luck next time ...'
      puts "The word was #{@game.word}."
    end
  end
end

HangmanCLI.new.play
