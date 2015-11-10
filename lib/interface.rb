class Interface
  def initialize(game)
    @game = game
  end

  def print_game_state
    print_masked_word
    print_incorrect_guesses
  end

  def ask_for_guess
    print "What's your next guess? "
    gets.chomp.upcase
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

  def print_error(err)
    puts err
  end

  private

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
