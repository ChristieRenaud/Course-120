require 'pry'
module Hand
  def hit
    deck.deal(self)
  end

  def stay
    puts "#{name} stayed. #{name}'s hand is #{hand}"
  end

  def busted?
    total > 21
  end

  def total
    total = 0
    hand.each do |card|
      total += card.value
    end

    hand.select { |card| card.face.first == "Ace" }.count.times do
      break if total <= 21
      total -= 10
    end
    total
  end

  def show_hand
    hand.map do |card|
      "=> " + card.to_s
    end
  end

  def show_last_card
    hand.last.to_s
  end

  def show_first_card
    hand.first.to_s
  end

  def clear_hand
    self.hand = []
  end
end

class Player
  include Hand

  attr_accessor :name, :hand

  def initialize
    @name = ''
    @hand = []
  end

  def show_flop
    puts "#{name}'s cards are:"
    puts show_hand
    puts ""
  end
end

class Dealer
  include Hand

  attr_accessor :hand, :name

  def initialize
    @hand = []
    @name = ["Sonny", "Number 5", "R2D2", "Wall-E", "Hal"].sample
  end

  def show_flop
    puts "#{name}'s cards are:"
    puts "=> #{show_first_card}"
    puts "=> ??"
    puts ""
  end
end

class Deck
  SUITS = ['Hearts', 'Spades', 'Clubs', 'Diamonds']
  VALUES = ['2', '3', '4', '5', '6', '7', '8', '9', '10',
            'Jack', 'Queen', 'King', 'Ace']
  CARDS = VALUES.product(SUITS)

  attr_accessor :deck

  def initialize
    @deck = []
    reset
  end

  def deal(player)
    card = deck.sample
    player << card
    deck.delete(card)
  end

  def reset
    (0..51).each do |idx|
      deck[idx] = Card.new(CARDS[idx])
    end
  end
end

class Card
  attr_accessor :face

  def initialize(face)
    @face = face
  end

  def to_s
    "The #{face.first} of #{face.last}"
  end

  def value
    if ["King", "Queen", "Jack"].include?(face.first)
      10
    elsif face.first == "Ace"
      11
    else
      face.first.to_i
    end
  end
end

class Game
  TARGET_NUMBER = 21

  attr_accessor :deck, :human, :dealer

  def initialize
    @human = Player.new
    @dealer = Dealer.new
    @deck = Deck.new
  end

  def start
    display_welcome_message
    loop do
      deal_cards
      show_initial_cards
      player_turn
      dealer_turn if !busted?
      show_ending_hands
      show_result
      break unless play_again?
      reset
    end
    goodbye_message
  end

  private

  def display_welcome_message
    clear
    puts "Welcome to Twenty-One. The player to"
    puts "come closest to #{TARGET_NUMBER} without going over wins."
    assign_name
    puts "Hello #{human.name}."
    introduce_dealer
    puts "Let's play #{TARGET_NUMBER}!"
    puts ""
    sleep 1
  end

  def clear
    system('clear') || system('cls')
  end

  def assign_name
    answer = ''
    puts "What is your name?"
    loop do
      answer = gets.chomp
      break if answer.match(/\S+/)
      puts "Invalid response. Please enter a name:"
    end
    human.name = answer
  end

  def introduce_dealer
    puts "The dealer today is #{dealer.name}."
  end

  def deal_cards
    2.times { deck.deal(human.hand) }
    2.times { deck.deal(dealer.hand) }
  end

  def show_initial_cards
    human.show_flop
    sleep 2
    dealer.show_flop
    sleep 2
  end

  def hit(player_hand)
    deck.deal(player_hand)
  end

  def player_turn
    loop do
      answer = hit_or_stay
      if answer.start_with?('s')
        puts "#{human.name} stayed."
        puts ""
        break
      elsif answer.start_with?('h')
        hit(human.hand)
        display_card(human)
        sleep 2
        break if busted?
      else
        puts "Invalid response."
      end
    end
  end

  def hit_or_stay
    puts "Would you like to hit or stay?"
    puts "Your card total is #{human.total}"
    gets.chomp.downcase
  end

  def display_card(player)
    puts "#{player.name} drew:"
    puts "=> #{player.show_last_card}"
    puts ""
  end

  def answer_starts_with?(letter)
    answer.downcase.start_with?(letter)
  end

  def busted?
    human.busted? || dealer.busted?
  end

  def busted_message
    if human.busted?
      puts "#{human.name} busted! #{dealer.name} wins"
    elsif dealer.busted?
      puts "#{dealer.name} busted! #{human.name} wins"
    end
  end

  def dealer_turn
    loop do
      break unless dealer.total < TARGET_NUMBER - 4
      hit(dealer.hand)
      display_card(dealer)
      sleep 2
    end
  end

  def display_totals
    puts "#{human.name}'s total is #{human.total}."
    puts "#{dealer.name}'s total is #{dealer.total}."
  end

  def display_dealer_won
    display_totals
    puts "*** #{dealer.name} won ***"
  end

  def display_human_won
    display_totals
    puts "*** #{human.name} won ***"
  end

  def show_ending_hands
    puts "#{human.name}'s final cards are:"
    puts human.show_hand
    puts ""
    puts "#{dealer.name}'s final cards are:"
    puts dealer.show_hand
    puts ""
    sleep 2
  end

  def show_result
    if busted?
      busted_message
    elsif dealer.total > human.total
      display_dealer_won
    elsif human.total > dealer.total
      display_human_won
    else
      display_totals
      puts "It's a tie!"
    end
  end

  def play_again?
    answer = ''
    loop do
      puts "Would you like to play again? (y or n)"
      answer = gets.chomp.downcase
      break if ['y', 'n'].include?(answer)
      puts "Invalid response."
    end
    answer == "y"
  end

  def goodbye_message
    puts "Thank you for playing Twenty-one. Goodbye"
  end

  def reset
    deck.reset
    human.clear_hand
    dealer.clear_hand
    clear
  end
end

Game.new.start
