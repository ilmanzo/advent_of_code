pos = 50
p1 = 0
p2 = 0
File.each_line("input.txt") do |row|
  ticks = row[1..].to_i
  delta = row.starts_with?('L') ? -1 : 1

  p2 += ((100 + delta * pos) % 100 + ticks) // 100
  pos = (pos + delta * ticks) % 100
  p1 += 1 if pos == 0
end

puts "Part 1: #{p1}"
puts "Part 2: #{p2}"