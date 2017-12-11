class Cat
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def self.generic_greeting
    puts "Meow, meow!"
  end

  def personal_greeting
    puts "Meow from #{name}!"
  end

end

kitty = Cat.new('Sophie')

Cat.generic_greeting
kitty.personal_greeting
