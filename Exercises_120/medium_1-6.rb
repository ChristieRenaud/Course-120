class GuessingGame
  attr_accessor :guesses
  attr_reader :number
  def initialize
    @number = rand(1..100)
    @guesses_left = 7
  end


  def play

    display_remaining_guesses
    #request_a_guess
    #validate_guess
    #compare_guess_to_number
     #if guess is higher than number, display too high
     #if guess is less than number, display too low
     #if guess equals number, display you win, end game
     # subtract a guess
    #check remaining guesses, if zero, dislay message, end game and reset guesses
      #if not, start over


  end

  def display_remaining_guesses
    puts "You have #{guesses_left} guesses remaining."
  end
end

game = GuessingGame.new
game.play
