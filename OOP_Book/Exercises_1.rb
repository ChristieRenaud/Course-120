class Vehicle

  attr_accessor :color
  attr_reader :year
  attr_reader :model

  @@number_of_vehicles = 0

  def initialize(year, color, model)
    @year = year
    @color = color
    @model = model
    @current_speed = 0
    @@number_of_vehicles += 1
  end

  def self.print_number_of_vehicles
    "There are #{@@number_of_vehicles} vehicles"
  end

  def speed_up(number)
    @current_speed += number
    puts "You accelerate to #{number} mph."
  end

  def brake(number)
    @current_speed -= number
    puts "You decelerate #{number} mph."
  end

  def current_speed
    puts "You are now going #{@current_speed} mph."
  end

  def shut_off
    @current_speed = 0
    puts "You park"
  end

  def spray_paint(color)
    self.color = color
    puts "Your new #{color} paint job looks great."
  end

  def self.gas_mileage(gallons, miles)
    puts "#{miles / gallons} miles per gallon of gas"
  end

  def age
    "Your #{self.model} is #{years_old} years old."
  end

  private

  def years_old
    Time.now.year - self.year
  end
end

module Loadable
  def loads
    "I carry big loads"
  end
end

class MyCar < Vehicle
  NUMBER_OF_DOORS = 4

  def to_s
    "My car is a #{year} #{color} #{model}"
  end
end

class MyTruck < Vehicle
  include Loadable
  NUMBER_OF_DOORS = 2

  def to_s
    "My truck is a #{year} #{color} #{model}"
  end

end

#shadow = MyCar.new(1990, 'purple', 'dodge shadow')
# shadow.speed_up(20)
# shadow.current_speed
# shadow.speed_up(20)
# shadow.current_speed
# shadow.brake(20)
# shadow.current_speed
# shadow.brake(20)
# shadow.current_speed
# shadow.shut_car_off
# shadow.current_speed
# shadow.color = 'black'
# puts shadow.color
# puts shadow.year
# shadow.spray_paint('midnight blue')
# puts shadow.color
# MyCar.gas_mileage(13, 351)
#puts shadow
# puts Vehicle.print_number_of_vehicles
sienna = MyCar.new(2010, 'white', 'toyota sienna')
truck = MyTruck.new(2015, "black", 'Ford truck')
# puts sienna
# puts truck
# puts Vehicle.print_number_of_vehicles
# puts truck.loads

# puts Vehicle.ancestors
# puts '------------'
# puts MyCar.ancestors
# puts '------------'
# puts MyTruck.ancestors

# sienna.spray_paint('blue')
# truck.spray_paint('pink')
# puts sienna
# puts truck
# sienna.current_speed
# sienna.speed_up(50)
# sienna.current_speed
# sienna.brake(20)

puts sienna.age
puts truck.age