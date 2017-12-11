class Student

  def initialize(name, year)
    @name = name
    @year = year
  end
end

class Graduate < Student
  def initialize(name, year, parking)
    super(name, year)
    @parking = parking
  end
end

class Undergraduate < Student
end

freshman = Undergraduate.new("Luke", 2020)
puts freshman

graduate = Graduate.new("Ray", 2024, "no")
puts graduate