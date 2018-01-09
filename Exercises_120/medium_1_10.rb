require 'pry'
class Card
  include Comparable

  attr_reader :rank, :suit
  CONVERT_RANK_TO_VALUE = { "Jack"=> 11, "Queen" => 12, "King" => 13, "Ace" => 14 }.freeze

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def value
    if integer?(rank)
      rank
    else
      CONVERT_RANK_TO_VALUE[rank] 
    end
  end

  def integer?(rank)
    rank.to_s.to_i == rank
  end 

  # def <=>(other)
  #   value <=> other.value
  # end

  def <(other)
    value < other.value
  end

  def >(other)
    value > other.value
  end

  def to_s
    "#{rank} of #{suit}"
  end
end

class Deck
  RANKS = (2..10).to_a + %w(Jack Queen King Ace).freeze
  SUITS = %w(Hearts Clubs Diamonds Spades).freeze

  attr_accessor :deck

  def initialize
    reset
  end

  def reset
    self.deck = []
    RANKS.each do |rank|
      SUITS.each do |suit|
        deck << Card.new(rank, suit)
      end
    end
    deck.shuffle!
  end

  def draw
    reset if deck.empty?
    deck.pop
  end
end

class PokerHand
  attr_accessor :deck, :hand
 
  def initialize(deck)
    @deck = deck
    @hand = []
    draw_hand
  end

  def draw_hand
    5.times do 
      @hand << deck.draw 
    end
  end

  def print
    hand.each do |card|
      puts card
    end
  end

  def evaluate
    case
    when royal_flush?     then 'Royal flush'
    when straight_flush?  then 'Straight flush'
    when four_of_a_kind?  then 'Four of a kind'
    when full_house?      then 'Full house'
    when flush?           then 'Flush'
    when straight?        then 'Straight'
    when three_of_a_kind? then 'Three of a kind'
    when two_pair?        then 'Two pair'
    when pair?            then 'Pair'
    else                       'High card'
    end
  end

  private

  def royal_flush?
    hand.map(&:value).max == 14 && straight? && flush?
  end

  def straight_flush?
    straight? && flush?
  end

  def four_of_a_kind?
    hand.any? do |card| 
      hand.count { |array_card| array_card.rank == card.rank } == 4
    end
  end

  def full_house?
    hand.map(&:rank).uniq.size == 2
  end

  def flush?
    hand.map(&:suit).uniq.size == 1
  end

  def straight?
    hand_values = hand.map(&:value)
    hand_values.uniq.size == 5 &&
      hand_values.max - hand_values.min == 4
  end

  def three_of_a_kind?
    hand.any? do |card| 
      hand.count { |array_card| array_card.rank == card.rank } == 3
    end
  end

  def two_pair?
    hand.map(&:rank).uniq.size == 3
  end

  def pair?
    hand.map(&:rank).uniq.size == 4
  end
end

hand = PokerHand.new(Deck.new)
hand.print
puts hand.evaluate

class Array
  alias_method :draw, :pop
end

hand = PokerHand.new([
  Card.new(10,      'Hearts'),
  Card.new('Ace',   'Hearts'),
  Card.new('Queen', 'Hearts'),
  Card.new('King',  'Hearts'),
  Card.new('Jack',  'Hearts')
])
puts hand.evaluate == 'Royal flush'

hand = PokerHand.new([
  Card.new(8,       'Clubs'),
  Card.new(9,       'Clubs'),
  Card.new('Queen', 'Clubs'),
  Card.new(10,      'Clubs'),
  Card.new('Jack',  'Clubs')
])
puts hand.evaluate == 'Straight flush'

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(3, 'Diamonds')
])
puts hand.evaluate == 'Four of a kind'

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(5, 'Hearts')
])
puts hand.evaluate == 'Full house'

hand = PokerHand.new([
  Card.new(10, 'Hearts'),
  Card.new('Ace', 'Hearts'),
  Card.new(2, 'Hearts'),
  Card.new('King', 'Hearts'),
  Card.new(3, 'Hearts')
])
puts hand.evaluate == 'Flush'

hand = PokerHand.new([
  Card.new(8,      'Clubs'),
  Card.new(9,      'Diamonds'),
  Card.new(10,     'Clubs'),
  Card.new(7,      'Hearts'),
  Card.new('Jack', 'Clubs')
])
puts hand.evaluate == 'Straight'

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(6, 'Diamonds')
])
puts hand.evaluate == 'Three of a kind'

hand = PokerHand.new([
  Card.new(9, 'Hearts'),
  Card.new(9, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(8, 'Spades'),
  Card.new(5, 'Hearts')
])
puts hand.evaluate == 'Two pair'

hand = PokerHand.new([
  Card.new(2, 'Hearts'),
  Card.new(9, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(9, 'Spades'),
  Card.new(3, 'Diamonds')
])
puts hand.evaluate == 'Pair'

hand = PokerHand.new([
  Card.new(2,      'Hearts'),
  Card.new('King', 'Clubs'),
  Card.new(5,      'Diamonds'),
  Card.new(9,      'Spades'),
  Card.new(3,      'Diamonds')
])
puts hand.evaluate == 'High card'