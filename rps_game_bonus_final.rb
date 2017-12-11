class Move
  attr_reader :value
  VALUES = ['rock', 'paper', 'scissors', 'lizard', 'spock']

  def scissors?
    @value == "scissors"
  end

  def rock?
    @value == 'rock'
  end

  def paper?
    @value == 'paper'
  end

  def lizard?
    @value == 'lizard'
  end

  def spock?
    @value == 'spock'
  end

  def to_s
    @value
  end
end

class Rock < Move
  def initialize
    @value = 'rock'
  end

  def >(other_move)
    other_move.scissors? || other_move.lizard?
  end

  def <(other_move)
    other_move.paper? || other_move.spock?
  end
end

class Scissors < Move
  def initialize
    @value = 'scissors'
  end

  def >(other_move)
    other_move.paper? || other_move.lizard?
  end

  def <(other_move)
    other_move.rock? || other_move.spock?
  end
end

class Paper < Move
  def initialize
    @value = 'paper'
  end

  def >(other_move)
    other_move.rock? || other_move.spock?
  end

  def <(other_move)
    other_move.scissors? || other_move.lizard?
  end
end

class Lizard < Move
  def initialize
    @value = 'lizard'
  end

  def >(other_move)
    other_move.paper? || other_move.spock?
  end

  def <(other_move)
    other_move.scissors? || other_move.rock?
  end
end

class Spock < Move
  def initialize
    @value = 'spock'
  end

  def >(other_move)
    other_move.rock? || other_move.scissors?
  end

  def <(other_move)
    other_move.lizard? || other_move.paper?
  end
end

class Player
  attr_accessor :move, :name, :score

  def initialize
    set_name
    @score = 0
  end

  def increment_score
    self.score += 1
  end

  def convert_choice(choice)
    case choice
    when 'rock' then Rock.new
    when 'paper' then Paper.new
    when 'scissors' then Scissors.new
    when 'lizard' then Lizard.new
    when 'spock' then Spock.new
    end
  end
end

class Human < Player
  def set_name
    n = ""
    loop do
      puts "What's your name?"
      n = gets.chomp
      break unless n.empty?
      puts "Sorry, must enter a value."
    end
    self.name = n
  end

  def choose
    choice = nil
    loop do
      puts "Please choose rock, paper, scissors, lizard, or spock:"
      choice = gets.chomp
      break if Move::VALUES.include?(choice)
      puts "Sorry, invalid choice."
    end

    self.move = convert_choice(choice)
  end
end

class Computer < Player
  def choose(_)
    choice = Move::VALUES.sample
    self.move = convert_choice(choice)
  end
end

# Always chooses lizard
class R2D2 < Computer
  def set_name
    @name = "R2D2"
  end

  def choose(_)
    self.move = Lizard.new
  end
end

# Chooses paper or rock
class Hal < Computer
  def set_name
    @name = "Hal"
  end

  def choose(_)
    choice = ['rock', 'paper', 'paper'].sample
    self.move = convert_choice(choice)
  end
end

# Less likely to choose rock if it loses after having chosen rock.
# Analyzes choice after having played rock 4 times
class Echo < Computer
  def set_name
    @name = "Echo"
  end

  def games_lost_after_rock(history)
    games_lost_after_rock = 0
    history.games_played.times do |idx|
      if history.game_history[:computer_move][idx] == 'rock'
        if history.game_history[:winner][idx] == :human_won
          games_lost_after_rock += 1
        end
      end
    end
    games_lost_after_rock
  end

  def loss_percentage_after_rock(history)
    return 0 if history.games_played <= 1
    times_rock_played = history.game_history[:computer_move].count('rock')
    games_lost_after_rock(history) / times_rock_played.to_f * 100
  end

  def choices_adjusted_based_on_history(history)
    times_rock_played = history.game_history[:computer_move].count('rock')
    if loss_percentage_after_rock(history) >= 60 && times_rock_played > 4
      (Move::VALUES * 2 - ['rock']) + ['rock']
    else
      Move::VALUES
    end
  end

  def choose(history)
    choice = choices_adjusted_based_on_history(history).sample
    self.move = convert_choice(choice)
  end
end

# Makes a random choice
class Sonny < Computer
  def set_name
    @name = "Sonny"
  end
end

# After first game always chooses human's last choice
class Number5 < Computer
  def set_name
    @name = "Number 5"
  end

  def humans_last_choice(history)
    return Move::VALUES.sample if history.games_played == 0
    history.game_history[:human_move][history.games_played - 1]
  end

  def choose(history)
    self.move = convert_choice(humans_last_choice(history))
  end
end

class History
  attr_accessor :game_history

  def initialize
    @game_history = Hash.new([])
  end

  def record_round(human_move, computer_move, winner)
    game_history[:human_move] += [human_move]
    game_history[:computer_move] += [computer_move]
    game_history[:winner] += [winner]
  end

  def games_played
    game_history[:winner].size
  end
end

# RPS Game Orchestration
class RPSGame
  NUMBER_TO_WIN_MATCH = 3
  attr_accessor :human, :computer, :history

  def initialize
    @human = Human.new
    @computer = [R2D2.new, Hal.new, Echo.new, Sonny.new, Number5.new].sample
    @history = History.new
  end

  def clear_screen
    system('clear') || system('cls')
  end

  def display_welcome_message
    sleep 0.5
    puts "Welcome to Rock, Paper, Scissors, Lizard, Spock!"
    puts "Today your opponent is #{computer.name}. Good luck!"
    sleep 1.5
  end

  def display_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors, Lizard, Spock. Good bye!"
  end

  def display_moves
    puts "#{human.name} chose #{human.move}."
    puts "#{computer.name} chose #{computer.move}"
    sleep 1
  end

  def who_won
    if human.move > computer.move
      :human_won
    elsif human.move < computer.move
      :computer_won
    end
  end

  def display_round_winner
    if who_won == :human_won
      puts "#{human.name} won!"
    elsif who_won == :computer_won
      puts "#{computer.name} won!"
    else
      puts "It's a tie!"
    end
    sleep 1
  end

  def play_round(history)
    human.choose
    computer.choose(history)
    display_moves
    display_round_winner
  end

  def increment_winner_score
    if who_won == :human_won
      human.increment_score
    elsif who_won == :computer_won
      computer.increment_score
    end
  end

  def update_game_history(human_move, computer_move, winner)
    history.record_round(human_move, computer_move, winner)
  end

  def check_score
    if human.score >= NUMBER_TO_WIN_MATCH
      puts "**#{human.name} won the match!**"
    elsif computer.score >= NUMBER_TO_WIN_MATCH
      puts "**#{computer.name} won the match!**"
    end
  end

  def keep_score(human_move, computer_move, winner)
    increment_winner_score
    update_game_history(human_move, computer_move, winner)
    check_score
  end

  def match_over?
    [human.score, computer.score].include?(NUMBER_TO_WIN_MATCH)
  end

  def display_match_winner
    puts "The final score is:"
    puts "#{human.name}: #{human.score}, #{computer.name}: #{computer.score}"
  end

  def clear_score
    human.score = 0
    computer.score = 0
  end

  def end_of_match
    sleep 1
    display_match_winner
    clear_score
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp
      break if ['y', 'n'].include? answer.downcase
      puts "Sorry, must be y or n."
    end

    return false if answer.downcase == 'n'
    return true if answer.downcase == 'y'
  end

  def play
    display_welcome_message
    loop do
      clear_screen
      loop do
        play_round(history)
        keep_score(human.move.value, computer.move.value, who_won)
        break if match_over?
      end
      end_of_match
      break unless play_again?
    end
    display_goodbye_message
  end
end

system('clear') || system('cls')
RPSGame.new.play
