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
    @commands = command_string.split
    @stack = Stack.new
    @register = Register.new
  end

  def eval
    @commands.each do |command|
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


Minilang.new('PRINT').eval
# 0

Minilang.new('5 PUSH 3 MULT PRINT').eval
# 15

Minilang.new('5 PRINT PUSH 3 PRINT ADD PRINT').eval
# 5
# 3
# 8

Minilang.new('5 PUSH 10 PRINT POP PRINT').eval
# 10
# 5

Minilang.new('5 PUSH POP POP PRINT').eval
# Empty stack!

Minilang.new('3 PUSH PUSH 7 DIV MULT PRINT ').eval
# 6

Minilang.new('4 PUSH PUSH 7 MOD MULT PRINT ').eval
# 12

Minilang.new('-3 PUSH 5 XSUB PRINT').eval
# Invalid token: XSUB

Minilang.new('-3 PUSH 5 SUB PRINT').eval
# 8

Minilang.new('6 PUSH').eval
# (nothing printed; no PRINT commands)
