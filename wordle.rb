# frozen_string_literal: false

# Entire game
class Game
  def initialize
    @player = Player.new
    start_game
  end

  def start_game
    @word = pick_word.upcase.split('')
    @tries = 0
    @board = Array.new(5, '_')
    @showboard = Array.new(5, '_')
    @bin = []
    puts 'Guess a 5-letter word!'
    check_letters(@player.guess)
  end

  def pick_word
    dictionary.sample
  end

  def check_letters(guess) # rubocop:todo Metrics/MethodLength
    guess.each_with_index do |guessed_letter, guessed_index|
      if guessed_letter == @word[guessed_index]
        @showboard[guessed_index] = "\e[32m#{guessed_letter}\e[0m"
        @board[guessed_index] = guessed_letter
      elsif @word.include?(guessed_letter)
        @showboard[guessed_index] = "\e[33m#{guessed_letter}\e[0m"
      else
        @showboard[guessed_index] = "\e[31m#{guessed_letter}\e[0m"
      end
      @bin.push(guessed_letter.to_s) unless @bin.include?(guessed_letter)
    end
    @tries += 1
    check_if_won
  end

  def check_if_won
    if @board.include?('_')
      print_board
      end_game if check_if_lost
      check_letters(@player.guess)
    else
      puts "\e[32mYou won!\e[0m The word was #{@word.join}. Starting new game"
      start_game
    end
  end

  def check_if_lost
    true if @tries >= 6
  end

  def end_game
    puts "\e[31mGame over!\e[0m The word was #{@word.join}. Starting new game."
    start_game
  end

  def print_board
    current_board = @showboard.map { |letter| "#{letter} " }.join
    puts "[#{@tries}/6] #{current_board}"
    print "Guessed letters: #{@bin.join(', ')}"
    puts
  end

  def dictionary
    %w[about above alert month model lease laugh suite staff young close clean]
  end
end

# Player actions
class Player
  def guess
    guess = gets.chomp.upcase.split('')
    return guess if guess.size == 5 || !guess.any { |letter| letter.is_a(String) }

    puts "This word doesn't have 5 letters! Try again"
    self.guess
  end
end

Game.new
