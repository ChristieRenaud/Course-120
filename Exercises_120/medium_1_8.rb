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

  def <=>(other)
    value <=> other.value
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
    deck = []
    RANKS.each do |rank|
      SUITS.each do |suit|
        deck << Card.new(rank, suit)
      end
    end
    deck
  end
  
  def monitor_deck_size
    reset if deck.size == 0
  end 

  def draw
  end
end

deck = Deck.new
drawn = []
# 52.times { drawn << deck.draw }
# drawn.count { |card| card.rank == 5 } == 4
# drawn.count { |card| card.suit == 'Hearts' } == 13

drawn2 = []
puts Card.new(2, "Hearts") == Card.new(2, "Diamonds")
# 52.times { drawn2 << deck.draw }
# drawn != drawn2 # Almost always.

# cards = [Card.new(2, 'Hearts'),
#          Card.new(10, 'Diamonds'),
#          Card.new('Ace', 'Clubs')]
# #puts cards

# puts cards.min == Card.new(2, 'Hearts')
# puts cards.max == Card.new('Ace', 'Clubs')

# cards = [Card.new(5, 'Hearts')]
# puts cards.min == Card.new(5, 'Hearts')
# puts cards.max == Card.new(5, 'Hearts')

# cards = [Card.new(4, 'Hearts'),
#          Card.new(4, 'Diamonds'),
#          Card.new(10, 'Clubs')]
# puts cards.min.rank == 4
# puts cards.max == Card.new(10, 'Clubs')

# cards = [Card.new(7, 'Diamonds'),
#          Card.new('Jack', 'Diamonds'),
#          Card.new('Jack', 'Spades')]
# puts cards.min == Card.new(7, 'Diamonds')
# puts cards.max.rank == 'Jack'

# cards = [Card.new(8, 'Diamonds'),
#          Card.new(8, 'Clubs'),
#          Card.new(8, 'Spades')]
# puts cards.min.rank == 8
# puts cards.max.rank == 8
