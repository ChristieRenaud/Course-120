class Board
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # cols
                  [[1, 5, 9], [3, 5, 7]]              # diagonals

  def initialize
    @squares = {}
    reset
  end

  # rubocop: disable Metrics/AbcSize
  def draw
    puts "     |     |"
    puts "  #{@squares[1]}  |  #{@squares[2]}  |  #{@squares[3]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[4]}  |  #{@squares[5]}  |  #{@squares[6]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[7]}  |  #{@squares[8]}  |  #{@squares[9]}"
    puts "     |     |"
  end
  # rubocop: enable Metrics/AbcSize

  def []=(num, marker)
    @squares[num].marker = marker
  end

  def unmarked_keys
    @squares.keys.select { |key| @squares[key].unmarked? }
  end

  def full?
    unmarked_keys.empty?
  end

  def someone_won?
    !!winning_marker
  end

  def winning_marker
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      if identical_markers?(3, squares)
        return squares.first.marker
      end
    end
    nil
  end

  def find_target_square(player_marker)
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      if identical_markers?(2, squares) &&
         squares.select(&:marked?).collect(&:marker).min == player_marker
        return @squares.select { |k, v| line.include?(k) && v.unmarked? }
                       .keys.first
      end
    end
    nil
  end

  def square_five_free?
    @squares[5].unmarked?
  end

  def reset
    (1..9).each { |key| @squares[key] = Square.new }
  end

  private

  def identical_markers?(number, squares)
    markers = squares.select(&:marked?).collect(&:marker)
    return false if markers.size != number
    markers.min == markers.max
  end
end

class Square
  INITIAL_MARKER = " "

  attr_accessor :marker

  def initialize(marker=INITIAL_MARKER)
    @marker = marker
  end

  def to_s
    @marker
  end

  def unmarked?
    marker == INITIAL_MARKER
  end

  def marked?
    marker != INITIAL_MARKER
  end
end

class Player
  attr_accessor :marker, :name, :score

  def initialize
    @marker = nil
    @name = nil
    @score = 0
  end

  def increment_score
    self.score += 1
  end

  def won_match?
    score == TTTGame::GAMES_TO_WIN
  end

  def reset_score
    self.score = 0
  end
end

class TTTGame
  FIRST_TO_MOVE = "Choose"
  GAMES_TO_WIN = 5
  COMPUTER_NAMES = ["Number 5", "Echo", "Hal", "R2D2", "Wall-E"]

  attr_reader :board, :human, :computer

  def initialize
    @board = Board.new
    @human = Player.new
    @computer = Player.new
    @current_marker = nil
  end

  # rubocop: disable Metrics/MethodLength
  def play
    display_welcome_message
    clear
    loop do
      loop do
        display_board
        loop do
          current_player_moves
          break if game_over?
          clear_screen_and_display_board
        end
        display_after_game_results_and_record_score
        break if someone_won_match?
        reset_after_game
      end
      display_winner

      break unless play_again?
      reset_and_display_message_after_match
    end
    display_goodbye_message
  end
  # rubocop: enable Metrics/MethodLength

  private

  def display_welcome_message
    clear
    puts "Welcome to Tic Tac Toe!"
    puts "The first player to win 5 games wins the match."
    assign_human_name
    puts "Hello #{human.name}!"
    human_chooses_marker
    display_human_marker
    assign_computer_name
    sleep 1
    puts "Your opponent today is #{computer.name}."
    determine_computer_marker
    display_computer_marker
    determine_first_player
    sleep 1
  end

  def display_after_game_results_and_record_score
    display_result
    keep_score
    display_match_score
    sleep 2
  end

  def reset_and_display_message_after_match
    reset_after_match
    display_play_again_message
  end

  def display_computer_marker
    puts "#{computer.name}'s marker is a #{computer.marker}."
    sleep 2
  end

  def display_human_marker
    puts "OK, your marker is a #{human.marker}"
  end

  def assign_human_name
    answer = ''
    puts "What is your name?"
    loop do
      answer = gets.chomp
      break if answer.match(/\S+/)
      puts "Invalid response. Please enter a name:"
    end
    human.name = answer
  end

  def assign_computer_name
    computer.name = COMPUTER_NAMES.sample
  end

  def determine_first_player
    @first_player = who_goes_first
    @current_marker = @first_player
    if @current_marker == human.marker
      puts "You move first!"
    else
      puts "#{computer.name} moves first"
    end
  end

  def human_chooses_marker
    answer = ''
    puts "What marker would you like to use today?"
    puts "Choose X, O, or any other single character."
    loop do
      answer = gets.chomp
      break if answer.chars.count { |char| char =~ /[\S]/ } == 1
      puts "Invalid choice. Please choose one character for your marker."
    end
    human.marker = answer
  end

  def determine_computer_marker
    computer.marker = if human.marker.downcase == "x"
                        "O"
                      else
                        "X"
                      end
  end

  def who_goes_first
    if FIRST_TO_MOVE == "Choose"
      ask_user_order_preference
    elsif FIRST_TO_MOVE == "Human"
      human.marker
    else
      computer.marker
    end
  end

  def ask_user_order_preference
    answer = nil
    loop do
      puts "Would you like to go first? Answer y or n."
      answer = gets.downcase.chomp
      break if ['y', 'n'].include? answer
      puts "Sorry, invalid response."
    end
    answer == "y" ? human.marker : computer.marker
  end

  def display_goodbye_message
    puts "Thanks for playing Tic Tac Toe! Goodbye!"
  end

  def display_board
    puts "You're a #{human.marker}. #{computer.name} is a #{computer.marker}"
    puts ""
    board.draw
    puts ""
  end

  def clear_screen_and_display_board
    clear
    display_board
  end

  def joinor(array, delimiter=', ', word='or')
    case array.size
    when 0 then ''
    when 1 then array.first.to_s
    when 2
      "#{array[0]} #{word} #{array[1]}"
    else
      array[0, array.size - 1].join(delimiter) +
        "#{delimiter}#{word} #{array[-1]}"
    end
  end

  def human_moves
    puts "Choose a square (#{joinor(board.unmarked_keys, ', ')}): "
    square = nil

    loop do
      square = gets.chomp.to_i
      break if board.unmarked_keys.include?(square)
      puts "Sorry, that's not a valid choice."
    end
    board[square] = human.marker
    sleep 0.5
  end

  def computer_has_two_markers?
    board.find_target_square(computer.marker)
  end

  def human_has_two_markers?
    board.find_target_square(human.marker)
  end

  def computer_moves
    computer_marker = computer.marker
    if computer_has_two_markers?
      board[winning_target_square] = computer_marker
    elsif human_has_two_markers?
      board[defensive_target_square] = computer_marker
    elsif square_five_empty?
      board[5] = computer_marker
    else
      board[random_unmarked_square] = computer_marker
    end
    sleep 0.5
  end

  def winning_target_square
    board.find_target_square(computer.marker)
  end

  def defensive_target_square
    board.find_target_square(human.marker)
  end

  def random_unmarked_square
    board.unmarked_keys.sample
  end

  def square_five_empty?
    board.square_five_free?
  end

  def current_player_moves
    if human_turn?
      human_moves
      @current_marker = computer.marker
    else
      computer_moves
      @current_marker = human.marker
    end
  end

  def human_turn?
    @current_marker == human.marker
  end

  def display_result
    clear_screen_and_display_board
    case board.winning_marker
    when human.marker
      puts "You won this game!"
    when computer.marker
      puts "#{computer.name} won this game!"
    else
      puts "It's a tie!"
    end
  end

  def game_over?
    board.someone_won? || board.full?
  end

  def keep_score
    case board.winning_marker
    when human.marker
      human.increment_score
    when computer.marker
      computer.increment_score
    end
  end

  def display_match_score
    puts "The current score is:"
    puts "#{human.name}: #{human.score}, #{computer.name}: #{computer.score}"
  end

  def someone_won_match?
    human.score == GAMES_TO_WIN || computer.score == GAMES_TO_WIN
  end

  def display_winner
    if human.won_match?
      puts "**Congratulations, #{human.name} won the match!**"
    elsif computer.won_match?
      puts "**#{computer.name} won the match!**"
    end
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y, n)"
      answer = gets.chomp.downcase
      break if ['y', 'n'].include? answer
      puts "Sorry, must be y or n"
    end

    answer == 'y'
  end

  def clear
    system('clear') || system('cls')
  end

  def reset_after_game
    board.reset
    @current_marker = @first_player
    clear
  end

  def reset_after_match
    reset_after_game
    human.reset_score
    computer.reset_score
  end

  def display_play_again_message
    puts "Let's play again!"
    sleep 1
    clear
  end
end

game = TTTGame.new
game.play
