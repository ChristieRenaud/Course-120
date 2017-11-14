#Lesson2_Exercises.rb

#1.
class Person
  attr_accessor :first_name, :last_name
  
  def initialize(full_name)
    parse_full_name(full_name)
  end

  def name
    "#{first_name} #{last_name}".strip
  end

  def name=(full_name)
    parse_full_name(full_name)
  end

  private

  def parse_full_name(full_name)
    parts = full_name.split
    self.first_name = parts.first
    self.last_name = parts.size > 1 ? parts.last : ''
  end

  def to_s
    name
  end

end

bob = Person.new('Robert Smith')
rob = Person.new('Robert Smith')

bob.name == rob.name

#puts "The person's name is #{bob.name}"
#puts "The person's name is " + bob.name
#puts "The person's name is #{bob}"

#------------------------------------

class Pet

  def run
    'running!'
  end

  def jump
    'jumping!'
  end
end

class Cat < Pet
  def speak
    'meow!'
  end
end

class Dog < Pet

  def speak
    'bark!'
  end

  def swim
    'swimming!'
  end

  def fetch
    'fetching!'
  end
end

class Bulldog < Dog
  def swim
    "can't swim!"
  end
end

pete = Pet.new
kitty = Cat.new
dave = Dog.new
bud = Bulldog.new

puts pete.run
#pete.speak

puts kitty.run
puts kitty.speak
# kitty.fetch

puts dave.speak

puts bud.run
puts bud.swim


