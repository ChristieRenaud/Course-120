# Question 1
# "Hello"
#  no method
# Wrong number of arguments
# "Goodbye"
# NoMethod

# Question 2
# class Hello
#   def self.hi
#     greeting = Greeting.new
#     greeting.greet("Hello")
#   end
# end

# Question 3
class AngryCat
  def initialize(age, name)
    @age  = age
    @name = name
  end

  def age
    puts @age
  end

  def name
    puts @name
  end

  def hiss
    puts "Hisssss!!!"
  end
end

fluffy = AngryCat.new("Fluffy", 6)
ron = AngryCat.new("Ron", 8)


# Question 4
class Cat
  def initialize(type)
    @type = type
  end

  def to_s
    puts "I am a #{@type} cat"
  end
end

tabby = Cat.new("tabby")
tabby.to_s

