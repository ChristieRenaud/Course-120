class GuessingGame
  NUMBER_OF_GUESSES = 
  attr_accessor :guesses_left, :number
  attr_reader :range_first_number, :range_second_number
  def initialize(num1, num2)
    @range_first_number = num1
    @range_second_number = num2
    @number = nil
    @guesses_left = nil
  end

  def play
    reset
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
  end

  private

  def size_of_range
    range_second_number - range_first_number + 1
  end

  def reset
    self.guesses_left = Math.log2(size_of_range).to_i + 1
    self.number = rand(range_first_number..range_second_number)
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
      puts "Enter a number between #{range_first_number}"\
           " and #{range_second_number}:"
      answer = gets.chomp
      break if answer.to_i.to_s == answer && 
               (range_first_number..range_second_number).cover?(answer.to_i)
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
game = GuessingGame.new(501, 1500)
game.play
game.play
