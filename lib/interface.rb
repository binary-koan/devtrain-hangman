class Interface
  def initialize(game)
    @game = game
  end

  def print_game_state
    puts masked_word_display
    puts incorrect_guess_display if @game.incorrect_guesses.size > 0
  end

  def ask_for_guess
    print "What's your next guess? "
    gets.chomp.upcase
  end

  def print_game_result
    if @game.won?
      puts "Well done!"
      puts "The word was indeed #{@game.word}."
    else
      puts "Better luck next time ..."
      puts "The word was #{@game.word}."
    end
  end

  def print_error(err)
    puts err
  end

  private

  def masked_word_display
    word = @game.word.chars.map { |char| @game.guessed?(char) ? char : '_' }.join

    "I'm thinking of a word like #{word}"
  end

  def incorrect_guess_display
    count = @game.incorrect_guesses.size
    guesses = @game.incorrect_guesses.to_a.join(' ')
    letters = count == 1 ? "letter" : "letters"

    "So far, you've guessed #{count} #{letters} incorrectly: #{guesses}"
  end
end
