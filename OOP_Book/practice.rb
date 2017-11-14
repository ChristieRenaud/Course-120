# good_dog.rb

class GoodDog
  def initialize(name)
    @name = name
  end

  def name          # gets name
    @name
  end

  def name=(n)      # sets name
    @name = n
  end

  def speak 
    "#{name} says Arf!"   # calling the instance method name to get the name
  end
end

sparky = GoodDog.new("Sparky")
puts sparky.speak
puts sparky.name
sparky.name = "Spartacus"
puts sparky.name
puts sparky.speak

# fido = GoodDog.new("Fido")
# puts fido.speak

class GoodDog
  attr_accessor :name     #replaces the name getter and setter methds
  
  def initialize(name)
    @name = name
  end

  def speak 
    "#{name} says Arf!"   # calling the instance method name to get the name
  end
end

class GoodDog
  attr_accessor :name, :height, :weight

  def initialize(n, h, w)
    @name = n
    @height = h
    @weight = w
  end

  def speak 
    "#{name} says Arf!"   # calling the instance method name to get the name
  end

  def change_info(n, h, w)
    self.name = n
    self.height = h
    self.weight = w
  end

  def info
    "#{self.name} weighs #{self.weight} and is #{self.height} tall."
  end
end

sparky = GoodDog.new('Sparky', '12 inches', '10 lbs')
puts sparky.info

sparky.change_info('Spartacus', '24 inches', '45 lbs')
puts sparky.info