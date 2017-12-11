class Banner
  def initialize(message, width=message.length+4)
    @message = message
    @width = width
  end

  def to_s
    [horizontal_rule, empty_line, message_line, empty_line, horizontal_rule].join("\n")
  end

  private

  def inside_box_length
    @width - 2
  end

  def horizontal_rule
    '+' + ('-' * inside_box_length) + '+'
  end

  def empty_line
    '|' + (' ' * inside_box_length) + '|'
  end

  def message_line
    "|#{@message.center(inside_box_length)}|"
  end
end

banner = Banner.new('To boldly go where no one has gone before.', 80)
puts banner
# +--------------------------------------------+
# |                                            |
# | To boldly go where no one has gone before. |
# |                                            |
# +--------------------------------------------+
banner = Banner.new('To boldly go where no one has gone before.')
puts banner

banner = Banner.new('')
puts banner
# +--+
# |  |
# |  |
# |  |
# +--+