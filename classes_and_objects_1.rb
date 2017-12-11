class Cat
  def initialize(n)
    @name = n
  end

  def greet
    puts "Hello! My name is #{n}!"
  end
end

kitty = Cat.new("Sophie")
kitty.greet