class GuessingGame
  attr_accessor :guesses_left, :number
  attr_reader :number
  def initialize
    @number = rand(1..100)
    @guesses_left = 7
  end

  def play
    loop do
      display_remaining_guesses
      guess = enter_a_guess
      if won?(guess)
        puts "You win!"
        puts ""
        break
      elsif guess < number
        puts "Your guess is too low"
      else
        puts "Your guess is too high"
      end
      puts ""
      subtract_a_guess
      if out_of_guesses?
        puts "The number is #{number}"
        puts "You are out of guesses. You lose."
        puts ""
        break
      end
    end
    reset
  end

  private

  def reset
    self.guesses_left = 7
    self.number = rand(1..100)
  end

  def display_remaining_guesses
    puts "You have #{guesses_left} guesses remaining."
  end

  def subtract_a_guess
    self.guesses_left -= 1
  end

  def enter_a_guess
    answer = ''
    loop do
      puts "Enter a number between 1 and 100:"
      answer = gets.chomp
      break if answer.to_i.to_s == answer && (1..100).cover?(answer.to_i)
      puts "Invalid input."
    end
    answer.to_i
  end

  def out_of_guesses?
    guesses_left == 0
  end

  def won?(guess)
    guess == number
  end

  def game_over(guess)
    out_of_guesses? || won?(guess)
  end
end
game = GuessingGame.new
game.play
game.play
