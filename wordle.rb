# frozen_string_literal: false

# Entire game
class Game
  def initialize
    @player = Player.new
    start_game
  end

  def start_game
    @word = pick_word
    @tries = 0
    @board = '_____'
    puts 'Guess a 5-letter word!'
    @player.guess
  end

  def pick_word
    dictionary.sample
  end

  def print_board
    puts @board
  end

  def dictionary
    %w[about above alert month model lease laugh suite staff young close clean]
  end
end

# Player actions
class Player < Game
  def guess
    guess = gets.chomp.split
    return if guess.size == 5

    puts "This word doesn't have 5 letters! Try again"
    self.guess
  end
end

Game.new
