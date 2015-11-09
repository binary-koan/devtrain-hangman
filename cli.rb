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
    print_masked_word
    print_incorrect_guesses
    get_new_guess
  end

  def get_new_guess
    loop do
      print "What's your next guess? "
      guess = gets.chomp.upcase
      return if @game.apply_guess(guess)

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

  def print_masked_word
    print "I'm thinking of a word like "
    puts @game.word.chars.map { |char| @game.guessed?(char) ? char : '_' }.join
  end

  def print_incorrect_guesses
    incorrect_count = @game.incorrect_guesses.size

    if incorrect_count > 0
      letters = incorrect_count == 1 ? 'letter' : 'letters'
      print "So far, you've guessed #{incorrect_count} #{letters} incorrectly: "
      puts @game.incorrect_guesses.to_a.join(' ')
    end
  end
end

HangmanCLI.new.play
