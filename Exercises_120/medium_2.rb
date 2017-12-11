require 'pry'

class FixedArray
  attr_accessor :array
  def initialize(number_of_elements)
    @array = [nil] * number_of_elements
    @num_elements = number_of_elements
  end

  def to_a
    array
  end

  def out_of_bounds_index(idx)
    idx > (@num_elements - 1) || idx < -@num_elements 
  end

  def []=(idx, value)
    if out_of_bounds_index(idx)
      raise IndexError.new
    else
      self.array[idx] = value
    end
  end

  def [](idx)
    if out_of_bounds_index(idx)
      raise IndexError.new
    else
      array[idx]
    end
  end

  def to_s
    array.to_s
  end
end



fixed_array = FixedArray.new(5)
puts fixed_array[3] == nil
puts fixed_array.to_a == [nil] * 5

fixed_array[3] = 'a'
puts fixed_array[3] == 'a'
puts fixed_array.to_a == [nil, nil, nil, 'a', nil]

fixed_array[1] = 'b'
puts fixed_array[1] == 'b'
puts fixed_array.to_a == [nil, 'b', nil, 'a', nil]

fixed_array[1] = 'c'
puts fixed_array[1] == 'c'
puts fixed_array.to_a == [nil, 'c', nil, 'a', nil]

fixed_array[4] = 'd'
puts fixed_array[4] == 'd'
puts fixed_array.to_a == [nil, 'c', nil, 'a', 'd']
puts fixed_array.to_s == '[nil, "c", nil, "a", "d"]'

puts fixed_array[-1] == 'd'
puts fixed_array[-4] == 'c'

begin
  fixed_array[6]
  puts false
rescue IndexError
  puts true
end

begin
  fixed_array[-7] = 3
  puts false
rescue IndexError
  puts true
end
