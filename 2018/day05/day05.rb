def react(input)
  stack = []
  input.each do |p|
    if !stack.last.nil? && stack.last.downcase == p.downcase && stack.last != p
      stack.pop
    else
      stack << p
    end
  end
  stack.length
end

input = File.read("input.txt").chomp.chars
puts "Part1=",react(input)
units = input.map(&:downcase).uniq
shortest = input.length
units.each do |unit|
  input_fixed = input.reject { |p| [unit, unit.upcase].include? p }
  len = react(input_fixed)
  shortest=len if len<shortest
end
puts "Part2=",shortest

