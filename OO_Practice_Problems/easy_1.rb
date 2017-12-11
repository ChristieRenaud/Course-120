# Question 1
# all are objects
# call class on them to find what class they belong to.

# Question 2
module Speed
  def go_fast
    puts "I am a #{self.class} and going super fast!"
  end
end

class Car
  include Speed
  def go_slow
    puts "I am safe and driving slow."
  end
end

class Truck
  include Speed
  def go_very_slow
    puts "I am a heavy truck and like going very slow"
  end
end

dodge = Truck.new
gti = Car.new

dodge.go_fast
gti.go_fast