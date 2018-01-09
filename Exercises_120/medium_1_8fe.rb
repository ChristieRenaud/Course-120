class Card
  include Comparable

  attr_reader :rank, :suit
  CONVERT_RANK_TO_VALUE = { "Jack"=> 11, "Queen" => 12, "King" => 13, "Ace" => 14 }.freeze
  CONVERT_SUIT_TO_VALUE = { "Diamonds" => 1, "Clubs" => 2, "Hearts" => 3, "Spades" => 4 }.freeze

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

  def suit_order
    CONVERT_SUIT_TO_VALUE[suit]
  end

  def integer?(rank)
    rank.to_s.to_i == rank
  end 

  def <=>(other)
    value == other.value ? suit_order <=> other.suit_order : value <=> other.value 
  end

  def to_s
    "#{rank} of #{suit}"
  end
end

cards = [Card.new(2, 'Hearts'),
         Card.new(10, 'Diamonds'),
         Card.new('Ace', 'Clubs')]
#puts cards

puts cards.min == Card.new(2, 'Hearts')
puts cards.max == Card.new('Ace', 'Clubs')

cards = [Card.new(5, 'Hearts')]
puts cards.min == Card.new(5, 'Hearts')
puts cards.max == Card.new(5, 'Hearts')

cards = [Card.new(4, 'Hearts'),
         Card.new(4, 'Diamonds'),
         Card.new(10, 'Clubs')]
puts cards.min.rank == 4
puts cards.min == Card.new(4, 'Diamonds')
puts cards.max == Card.new(10, 'Clubs')

cards = [Card.new(7, 'Diamonds'),
         Card.new('Jack', 'Diamonds'),
         Card.new('Jack', 'Spades')]
puts cards.min == Card.new(7, 'Diamonds')
puts cards.max == Card.new('Jack', 'Spades')

cards = [Card.new(8, 'Diamonds'),
         Card.new(8, 'Clubs'),
         Card.new(8, 'Spades')]
puts cards.min == Card.new(8, 'Diamonds')
puts cards.max == Card.new(8, 'Spades')
puts cards.min.rank == 8
puts cards.max.rank == 8
