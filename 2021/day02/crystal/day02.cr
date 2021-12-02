class Part1
  property depth, position
  @depth, @position = 0, 0

  def up(x)
    @depth -= x
  end

  def down(x)
    @depth += x
  end

  def forward(x)
    @position += x
  end

  def move(direction, x)
    case direction
    when "forward"
      forward x
    when "up"
      up x
    when "down"
      down x
    end
  end
end

class Part2 < Part1
  property aim
  @aim = 0

  def up(x)
    @aim -= x
  end

  def down(x)
    @aim += x
  end

  def forward(x)
    @depth += x*aim
    @position += x
  end
end

parts = [Part1.new, Part2.new]
File.each_line("../input.txt") do |line|
  direction, amount = line.split
  amount = amount.to_i32
  parts.each { |p| p.move direction, amount }
end

puts "Part1 Depth*Position = #{parts[0].depth*parts[0].position}"
puts "Part2 Depth*Position = #{parts[1].depth*parts[1].position}"
