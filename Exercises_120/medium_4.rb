require 'pry'

class CircularQueue
  attr_reader :buffer, :order_array

  def initialize(number)
    @buffer = Array.new(number)
    @order_array = Array.new
  end

  def queue_full?
    buffer.count(nil) == 0
  end

  def queue_empty?
    buffer.uniq == [nil]
  end

  def enqueue(num_to_add)
    if queue_full?
      buffer[oldest_position] = num_to_add
      order_array.shift
    elsif queue_empty?
      buffer[0] = num_to_add
    else 
      buffer[(newest_position + 1) % buffer.size] = num_to_add
    end
    @order_array << num_to_add
  end

  def oldest_object
    order_array.first
  end

  def newest_object
    order_array.last
  end

  def newest_position
    buffer.index(newest_object)
  end

  def oldest_position
    buffer.index(oldest_object)
  end

  def dequeue
    return nil if queue_empty?
    buffer[oldest_position] = nil
    order_array.shift
  end
end

queue = CircularQueue.new(3)
puts queue.dequeue == nil

queue.enqueue(1)
queue.enqueue(2)
puts queue.dequeue == 1

queue.enqueue(3)
queue.enqueue(4)
puts queue.dequeue == 2

queue.enqueue(5)
queue.enqueue(6)
queue.enqueue(7)
puts queue.dequeue == 5
puts queue.dequeue == 6
puts queue.dequeue == 7
puts queue.dequeue == nil

queue = CircularQueue.new(4)
puts queue.dequeue == nil

queue.enqueue(1)
queue.enqueue(2)
puts queue.dequeue == 1

queue.enqueue(3)
queue.enqueue(4)
puts queue.dequeue == 2

# queue.enqueue(5)
# queue.enqueue(6)
# queue.enqueue(7)
# puts queue.dequeue == 4
# puts queue.dequeue == 5
# puts queue.dequeue == 6
# puts queue.dequeue == 7
# puts queue.dequeue == nil