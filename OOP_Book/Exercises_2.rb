# Exercises_2.rb

class Student

  # attr_accessor :name
  # attr_writer :grade

  def initialize(name, grade)
    @name = name
    @grade = grade
  end

  def better_grade_than?(other_student)
    grade < other_student.grade
  end

  protected

  def grade
    @grade
  end

end

sue = Student.new("Sue", "A")
bob = Student.new("Bob", "D")
puts "Well done!" if sue.better_grade_than?(bob)