class Stack
  attr_accessor :stack_array

  def initialize
    @stack_array = []
  end

  def <<(other_value)
    stack_array << other_value
  end

  def empty?
    stack_array.empty?
  end

  def pop
    stack_array.pop
  end
end

class Register
  attr_accessor :value

  def initialize
    @value = 0
  end

  def to_s
    value.to_s
  end
end

class MinilangRuntimeError < RuntimeError; end
class BadTokenError < MinilangRuntimeError; end
class EmptyStackError < MinilangRuntimeError; end

class Minilang
  COMMANDS = ['PUSH', 'ADD', 'SUB', 'MULT', 'DIV', 'MOD', 'POP', 'PRINT']
  attr_accessor :register, :stack

  def initialize(command_string)
    @commands = command_string
    @stack = Stack.new
    @register = Register.new
  end

  def eval(degree)
    format(@commands, degree).split.each do |command|
      if command =~ /\A[-+]?\d+\z/
        register.value = command.to_i
      elsif !COMMANDS.include?(command)
        raise BadTokenError, "INVALID TOKEN: #{command}"
      else 
        send command.downcase 
      end
    end
  rescue MinilangRuntimeError => error
    puts error.message
  end
 
  def empty_stack
    raise EmptyStackError, "Empty stack!" if stack.empty?
  end

  def push
    stack << register.value
  end

  def add
    register.value += pop
  end

  def sub
    register.value -= pop
  end

  def mult
    register.value *= pop
  end

  def div
    register.value /= pop
  end

  def mod
    register.value %= pop
  end

  def pop
    empty_stack
    register.value = stack.pop
  end

  def print
    puts register
  end
end


# CENTIGRADE_TO_FAHRENHEIT =
#   '5 PUSH %<degrees_c>d PUSH 9 MULT DIV PUSH 32 ADD PRINT'
# Minilang.new(format(CENTIGRADE_TO_FAHRENHEIT, degrees_c: 100)).eval
# # 212
# Minilang.new(format(CENTIGRADE_TO_FAHRENHEIT, degrees_c: 0)).eval
# # 32
# Minilang.new(format(CENTIGRADE_TO_FAHRENHEIT, degrees_c: -40)).eval
# # -40

CENTIGRADE_TO_FAHRENHEIT =
  '5 PUSH %<degrees_c>d PUSH 9 MULT DIV PUSH 32 ADD PRINT'
minilang = Minilang.new(CENTIGRADE_TO_FAHRENHEIT)
minilang.eval(degrees_c: 100)
# 212
minilang.eval(degrees_c: 0)
# 32
minilang.eval(degrees_c: -40)
# -40