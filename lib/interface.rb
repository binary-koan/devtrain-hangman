class Interface
  HANGMAN_ART = File.read('art.txt').split("\n\n")

  def initialize(game)
    @game = game
  end

  def print_game_state
    puts masked_word_display
    puts incorrect_guess_display if @game.incorrect_guesses.size > 0
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
      puts "Well done!"
      puts "The word was indeed #{@game.word}."
    else
      puts hangman_with_text(Game::MAX_LIVES - 1,
        "Better luck next time ...",
        "The word was #{@game.word}.")
    end
  end

  private

  def masked_word_display
    word = @game.word.chars.map { |char| @game.guessed?(char) ? char : '_' }.join

    "I'm thinking of a word like #{word}"
  end

  def incorrect_guess_display
    count = @game.incorrect_guesses.size
    guesses = @game.incorrect_guesses.to_a
    letters = count == 1 ? "letter" : "letters"

    hangman_with_text(count - 1,
      "So far, you've guessed #{count} #{letters} incorrectly:",
      "#{guesses.join(" ")}")
  end

  def hangman_with_text(index, text1, text2)
    art = HANGMAN_ART[index].split("\n")
    art[3] = "#{pad_to_length(art[3], art[0].length)}  #{text1}"
    art[4] = "#{pad_to_length(art[4], art[0].length)}  #{text2}"
    art.join("\n")
  end

  def pad_to_length(line, length)
    line + " " * (length - line.length)
  end
end
