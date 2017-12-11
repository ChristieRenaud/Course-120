module Managing_Pets

  def add_pet(pet)
    @pets << pet
  end

  def number_of_pets
    pets.size
  end

  def print_pets
    pets.each { |pet| puts pet }
  end

end

class Owner
  include Managing_Pets
  attr_accessor :name, :pets

  def initialize(name)
    @name = name
    @pets = []
  end

end

class Pet
  attr_accessor :pet_type, :name
  def initialize(pet, name)
    @pet_type = pet
    @name = name
  end

  def to_s
    "a #{pet_type} named #{name}"
  end
end

class Shelter
  include Managing_Pets
  
  attr_accessor :pets
  def initialize
    @owners = {}
    @pets = []
  end

  def adopt(owner, pet)
    owner.add_pet(pet)
    @owners[owner.name] ||= owner
  end

  def print_adoptions
   @owners.each_pair do |name, owner|
    puts "#{name} has adopted the following pets:"
    owner.print_pets
    puts
    end
  end

  def print_available_pets
    puts "The Animal Shelter has the following unadopted pets:"
    self.print_pets
  end
end

# butterscotch = Pet.new('cat', 'Butterscotch')
# pudding      = Pet.new('cat', 'Pudding')
# darwin       = Pet.new('bearded dragon', 'Darwin')
# kennedy      = Pet.new('dog', 'Kennedy')
# sweetie      = Pet.new('parakeet', 'Sweetie Pie')
# molly        = Pet.new('dog', 'Molly')
# chester      = Pet.new('fish', 'Chester')

# phanson = Owner.new('P Hanson')
# bholmes = Owner.new('B Holmes')

# shelter = Shelter.new
# shelter.adopt(phanson, butterscotch)
# shelter.adopt(phanson, pudding)
# shelter.adopt(phanson, darwin)
# shelter.adopt(bholmes, kennedy)
# shelter.adopt(bholmes, sweetie)
# shelter.adopt(bholmes, molly)
# shelter.adopt(bholmes, chester).
# shelter.print_adoptions
# puts "#{phanson.name} has #{phanson.number_of_pets} adopted pets."
# puts "#{bholmes.name} has #{bholmes.number_of_pets} adopted pets."

summer = Pet.new('dog', 'Summer')
junior = Pet.new('dog', 'Junior')
patti = Pet.new('cat', 'Patti')

christie = Owner.new('Christie')
shelter = Shelter.new
shelter.adopt(christie, summer)
shelter.adopt(christie, patti)
shelter.adopt(christie, junior)
shelter.print_adoptions
puts "#{christie.name} has #{christie.number_of_pets} adopted pets."

shelter.add_pet(summer)
shelter.add_pet(junior)
shelter.print_available_pets
puts "The Animal Shelter has #{shelter.number_of_pets} unadopted pets"

